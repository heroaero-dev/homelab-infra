import subprocess

def run(cmd):
	print(f"\033[94m {cmd}\033[0m")
	try:
		subprocess.run(cmd, shell=True, check=True)
	except subprocess.CalledProcessError:
		print(f"\033[93 Skipped or failed: {cmd}\033[0m")
def main():
	print("\033[1m NGINX Ingress Reset Script (Python)\033[0m")

	run("helm uninstall nginx-main -n ingress-nginx")
	run("kubectl delete namespace ingress-nginx"

	print("\n Deleting leftover cluster-wide resources:")
	run("kubectl delete ingressclass nginx-main")
	run("kubectl delete clusterrole ingress-nginx")
	run("kubectl delete clusterrolebinding ingress-nginx")
	run("kubectl delete validatingwebhookconfiguration ingress-nginx-admission")
	
	print("\n Removing Helm repo (optional):")
	run("helm repo remove ingress-nginx")

	print("\n \033[92mNGINX Ingress cleanup complete. \033[0m")
if _name_ == "_main_":
	main()
