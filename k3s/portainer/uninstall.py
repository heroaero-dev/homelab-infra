import subprocess
import time

def run(cmd):
    print(f"\033[94m→ {cmd}\033[0m")
    try:
        subprocess.run(cmd, shell=True, check=True)
    except subprocess.CalledProcessError:
        print(f"\033[93m⚠️  Skipped or failed: {cmd}\033[0m")

def wait_for_namespace_termination(ns):
    print(f"\033[96m⏳ Waiting for namespace '{ns}' to terminate...\033[0m")
    while True:
        result = subprocess.run(
            f"kubectl get ns {ns} --no-headers",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL
        )
        if result.returncode != 0:
            break  # Namespace no longer exists
        time.sleep(2)
    print(f"\033[92m✅ Namespace '{ns}' fully terminated.\033[0m")

def main():
    print("\033[1m🧹 NGINX Ingress Reset Script (Python)\033[0m")

    run("helm uninstall nginx-main -n ingress-nginx")
    run("kubectl delete namespace ingress-nginx")
    wait_for_namespace_termination("ingress-nginx")

    print("\n🔍 Deleting leftover cluster-wide resources:")
    run("kubectl delete ingressclass nginx-main")
    run("kubectl delete clusterrole ingress-nginx")
    run("kubectl delete clusterrolebinding ingress-nginx")
    run("kubectl delete validatingwebhookconfiguration ingress-nginx-admission")

    print("\n🧼 Removing Helm repo (optional):")
    run("helm repo remove ingress-nginx")

    print("\n✅ \033[92mNGINX Ingress cleanup complete.\033[0m")

if __name__ == "__main__":
    main()

