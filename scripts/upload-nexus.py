import os
import requests
import argparse

def Download(url, filename):
    r = requests.get(url)
    with open("./tmp/%s" % filename, "wb") as code:
        code.write(r.content)

def Upload(host, repository, filename, directory, username=None, password=None):
    url = 'http://%s/repository/%s' % (host, repository)
    content = open(filename, 'rb').read()
    if username != None and password != None:
      auth = (username, password)
      resp = requests.put("%s/%s/%s" % (url, directory, filename.replace("./tmp/", "")), data=content, auth=auth)
    else:
      resp = requests.put("%s/%s/%s" % (url, directory, filename.replace("./tmp/", "")), data=content)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download package and upload to nexus.')
    parser.add_argument('--host', metavar='host', help='nexus host', required=True)
    parser.add_argument('--repository', metavar='repository', help='nexus repository name', required=True)
    parser.add_argument('--username',default=None, metavar='username', help='nexus username')
    parser.add_argument('--password',default=None, metavar='password', help='nexus password')
    parser.add_argument('--docker', default="19.03.8", metavar='docker', help='docker version, default: 19.03.8')
    parser.add_argument('--flannel', default="0.12.0", metavar='flannel', help='flannel version, default: 0.12.0')
    parser.add_argument('--etcd', default="3.4.5", metavar='etcd', help='etcd version, default: 3.4.5')
    parser.add_argument('--kubernetes', default="1.14.4", metavar='kubernetes', help='kubernetes version, default: 1.14.4')
    parser.add_argument('--cni', default="0.8.5", metavar='cni', help='cni plugin version, default: 0.8.5')
    options = parser.parse_args()

    if not os.path.exists("tmp"):
        os.makedirs("tmp")

    print("Download and Upload docker package...")
    Download("https://download.docker.com/linux/static/stable/x86_64/docker-%s.tgz" % options.docker, "docker-%s.tgz" % options.docker)
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/docker-%s.tgz" % options.docker, directory="/linux/static/stable/x86_64")

    print("Download and Upload flannel package...")
    Download("https://github.com/coreos/flannel/releases/download/v%s/flannel-v%s-linux-amd64.tar.gz" % (options.flannel, options.flannel), "flannel-v%s-linux-amd64.tar.gz" % options.flannel)
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/flannel-v%s-linux-amd64.tar.gz" % options.flannel, directory="/coreos/flannel/releases/download/v%s" % options.flannel)

    print("Download and Upload etcd package...")
    Download("https://github.com/coreos/etcd/releases/download/v%s/etcd-v%s-linux-amd64.tar.gz" % (options.etcd, options.etcd), "etcd-v%s-linux-amd64.tar.gz" % options.etcd)
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/etcd-v%s-linux-amd64.tar.gz" % options.etcd, directory="/coreos/etcd/releases/download/v%s" % options.etcd)

    print("Download and Upload kubernetes package...")
    directory = "/kubernetes-release/release/v%s/bin/linux/amd64" % options.kubernetes
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kube-apiserver" % options.kubernetes, "kube-apiserver")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kube-apiserver", directory=directory)
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kube-controller-manager" % options.kubernetes, "kube-controller-manager")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kube-controller-manager", directory=directory)
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kube-scheduler" % options.kubernetes, "kube-scheduler")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kube-scheduler", directory=directory)
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kubectl" % options.kubernetes, "kubectl")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kubectl", directory=directory)
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kube-proxy" % options.kubernetes, "kube-proxy")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kube-proxy", directory=directory)
    Download("https://storage.googleapis.com/kubernetes-release/release/v%s/bin/linux/amd64/kubelet" % options.kubernetes, "kubelet")
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/kubelet", directory=directory)

    print("Download and Upload cni-plugins package...")
    Download("https://github.com/containernetworking/plugins/releases/download/v%s/cni-plugins-linux-amd64-v%s.tgz" % (options.cni, options.cni), "cni-plugins-linux-amd64-v%s.tgz" % options.cni)
    Upload(host=options.host,repository=options.repository, username=options.username, password=options.password, filename="./tmp/cni-plugins-linux-amd64-v%s.tgz" % options.cni, directory="/containernetworking/plugins/releases/download/v%s" % options.cni)