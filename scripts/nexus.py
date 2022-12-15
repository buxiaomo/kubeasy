#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import argparse
import os
import sys
import requests
import json
from packaging.version import Version


def Download(url, path, quiet):
    response = requests.get(url, stream=True)
    size = 0
    chunk_size = 1024
    content_size = int(response.headers['content-length'])
    try:
        if response.status_code == 200:
            print('=> start download {name} {size:.2f} MB'.format(
                name=os.path.basename(path), size=content_size / chunk_size / 1024)
            )
            with open(path, 'wb') as file:
                for data in response.iter_content(chunk_size=chunk_size):
                    file.write(data)
                    size += len(data)
                    if not quiet:
                        print('\r' + '%s %.2f%%' % (
                            '*' * int(size * 50 / content_size), float(size / content_size * 100)), end=' ')
            print()
            return True
        else:
            raise Exception(response.status_code)
    except Exception as e:
        print("Exception occurs in Downloading, status code: %s..." % e)
        return False


class Nexus:
    def __init__(self, url, repository, username, password):
        self.url = url
        self.repository = repository
        self.username = username
        self.password = password

    def Upload(self, src, directory):
        url = "%s/service/rest/v1/components?repository=%s" % (self.url, self.repository)
        resp = None
        content = open(src, 'rb').read()
        payload = {
            'raw.directory': directory,
            'raw.asset1.filename': os.path.basename(src)
        }
        files = [
            (
                'raw.asset1', (
                    os.path.basename(src),
                    content,
                    'application/octet-stream'
                )
            )
        ]
        if self.username is not None and self.password is not None:
            auth = (self.username, self.password)
            resp = requests.request("POST", url, data=payload, files=files, auth=auth)
        else:
            resp = requests.request("POST", url, data=payload, files=files)
        if resp.status_code != 204:
            print("Upload failed, status code: %d" % resp.status_code)
            return False
        else:
            print("Upload success.")
            return True

    def Auth(self):
        url = '%s/service/rest/v1/status/check' % (self.url)
        resp = None
        if self.username is not None and self.password is not None:
            auth = (self.username, self.password)
            resp = requests.get(url, auth=auth)
        else:
            resp = requests.get(url)

        if resp.status_code != 200:
            return False
        else:
            return True


def downloadToLocal(arg):
    kubeVersion = arg.kubernetes[:4]

    basePath = os.path.split(os.path.realpath(__file__))[0]
    basePath = basePath + "/src/" + arg.kubernetes
    if not os.path.exists(basePath):
        os.makedirs(basePath)

    jsonFile = []
    version = arg.docker
    if version is not None:
        url = "https://download.docker.com/linux/static/stable/x86_64/docker-%s.tgz" % version
        if Download(url, "%s/docker-%s.tgz" % (basePath, version), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/docker-%s.tgz" % (arg.kubernetes, version),
                    'dest': "/linux/static/stable/x86_64"
                }
            )

    version = arg.containerd
    if version is not None:
        url = "https://github.com/containerd/containerd/releases/download/v%s/containerd-%s-linux-amd64.tar.gz" % (
            version, version)
        if Download(url, "%s/containerd-%s-linux-amd64.tar.gz" % (basePath, version), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/containerd-%s-linux-amd64.tar.gz" % (arg.kubernetes, version),
                    'dest': "/containerd/containerd/releases/download/v%s" % version
                }
            )

    version = arg.runc
    if version is not None:
        url = "https://github.com/opencontainers/runc/releases/download/v%s/runc.amd64" % version
        if Download(url, "%s/runc.amd64" % (basePath), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/runc.amd64" % (arg.kubernetes),
                    'dest': "/opencontainers/runc/releases/download/v%s" % version
                }
            )

    version = arg.crictl
    if version is not None:
        url = "https://github.com/kubernetes-sigs/cri-tools/releases/download/v%s/crictl-v%s-linux-amd64.tar.gz" % (
        version, version)
        if Download(url, "%s/crictl-v%s-linux-amd64.tar.gz" % (basePath, version), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/crictl-v%s-linux-amd64.tar.gz" % (arg.kubernetes, version),
                    'dest': "/kubernetes-sigs/cri-tools/releases/download/v%s" % version
                }
            )

    version = arg.etcd
    if version is not None:
        url = "https://github.com/coreos/etcd/releases/download/v%s/etcd-v%s-linux-amd64.tar.gz" % (version, version)
        if Download(url, "%s/etcd-v%s-linux-amd64.tar.gz" % (basePath, version), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/etcd-v%s-linux-amd64.tar.gz" % (arg.kubernetes, version),
                    'dest': "/coreos/etcd/releases/download/v%s" % version
                }
            )

    version = arg.cni
    if version is not None:
        if Version(version) >= Version('0.8.0'):
            url = "https://github.com/containernetworking/plugins/releases/download/v%s/cni-plugins-linux-amd64-v%s.tgz" % (
                version, version)
            filename = "cni-plugins-linux-amd64-v%s.tgz" % (version)
        else:
            url = "https://github.com/containernetworking/plugins/releases/download/v%s/cni-plugins-amd64-v%s.tgz" % (
                version, version)
            filename = "cni-plugins-amd64-v%s.tgz" % (version)
        if Download(url, "%s/%s" % (basePath, filename), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/%s" % (arg.kubernetes, filename),
                    'dest': "/containernetworking/plugins/releases/download/v%s" % version
                }
            )

    file_list = [
        "kube-apiserver",
        "kube-controller-manager",
        "kube-scheduler",
        "kubectl",
        "kube-proxy",
        "kubelet",
    ]
    for f in file_list:
        url = "https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/%s" % (
            arg.kubernetes, f)
        if Download(url, "%s/%s" % (basePath, f), arg.quiet):
            jsonFile.append(
                {
                    'src': "./scripts/src/%s/%s" % (arg.kubernetes, f),
                    'dest': "/kubernetes-release/release/v%s/bin/linux/amd64" % arg.kubernetes
                }
            )

    with open("%s/%s.json" % (basePath, arg.kubernetes), "w") as f:
        json.dump(jsonFile, f)

    print("files is save on src directory")


def uploadToNexus(arg):
    basePath = os.path.split(os.path.realpath(__file__))[0]
    basePath = basePath + "/src/" + arg.kubernetes

    nexus = Nexus(arg.url, arg.repository, arg.username, arg.password)
    if arg.username is not None or arg.password is not None:
        if not nexus.Auth():
            print("Username or Password is error!")
            sys.exit(2)

    try:
        with open("%s/%s.json" % (basePath, arg.kubernetes), "r") as f:
            print("Upload package to nexus...")
            for item in json.load(f):
                nexus.Upload(src=item.get('src'), directory=item.get('dest'))
    except FileNotFoundError:
        print("please use download commands to download package.")
    sys.exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download package and upload to nexus.')
    parser.add_argument('--kubernetes', metavar='string', required=True, help='kubernetes version')
    parser.add_argument('--etcd', metavar='string', required=True, help='etcd version')
    parser.add_argument('--cni', metavar='string', required=True, help='cni plugin version')
    parser.add_argument('--docker', metavar='string', required=True, help='docker version')
    parser.add_argument('--containerd', metavar='string', required=True, help='containerd version')
    parser.add_argument('--runc', metavar='string', required=True, help='runc version')
    parser.add_argument('--crictl', metavar='string', required=True, help='crictl version')

    subparsers = parser.add_subparsers(
        title='commands',
        description='download or upload',
        help='download or upload'
    )
    download = subparsers.add_parser('download')
    download.add_argument('--quiet', action='store_true', help='quiet download')
    download.set_defaults(func=downloadToLocal)

    upload = subparsers.add_parser('upload')
    upload.add_argument('--url', metavar='string', help='nexus url', required=True)
    upload.add_argument('--repository', metavar='string', help='nexus repository name', required=True)
    upload.add_argument('--username', default=None, metavar='string', help='nexus username')
    upload.add_argument('--password', default=None, metavar='string', help='nexus password')
    upload.set_defaults(func=uploadToNexus)

    args = parser.parse_args()

    try:
        args.func(args)
    except AttributeError:
        parser.print_help()
        parser.exit()
