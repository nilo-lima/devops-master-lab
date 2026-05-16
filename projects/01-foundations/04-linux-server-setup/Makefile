.PHONY: up down clean setup audit lint

up:
	vagrant up
	@echo "VM disponivel em 192.168.56.10"

down:
	vagrant halt

clean:
	vagrant destroy -f
	@echo "VM removida."

setup:
	cd infra && ansible-playbook -i inventory.ini site.yml

audit:
	vagrant ssh -c "sudo bash /vagrant/config/07-security-audit.sh"

COLLECTIONS_DIR := $(CURDIR)/infra/collections

lint:
	ansible-galaxy collection install -r infra/requirements.yml -p $(COLLECTIONS_DIR) --force
	cd infra && ANSIBLE_COLLECTIONS_PATH=$(COLLECTIONS_DIR) ansible-lint site.yml
