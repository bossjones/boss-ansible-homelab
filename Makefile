.PHONY: list help

PR_SHA                := $(shell git rev-parse HEAD)

define ASCILOGO
boss-ansible-homelab
=======================================
endef

export ASCILOGO

# http://misc.flogisoft.com/bash/tip_colors_and_formatting

RED=\033[0;31m
GREEN=\033[0;32m
ORNG=\033[38;5;214m
BLUE=\033[38;5;81m
NC=\033[0m

export RED
export GREEN
export NC
export ORNG
export BLUE

# verify that certain variables have been defined off the bat
check_defined = \
    $(foreach 1,$1,$(__check_defined))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $(value 2), ($(strip $2)))))

list_allowed_args := product ip command role tier

help:
	@printf "\033[1m$$ASCILOGO $$NC\n"
	@printf "\033[21m\n\n"
	@printf "=======================================\n"
	@printf "\n"

list:
	@$(MAKE) -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$$)/ {split($$1,A,/ /);for(i in A)print A[i]}' | sort

download-roles:
	ansible-galaxy install -r requirements.yml --roles-path ./roles/

raw:
	$(call check_defined, product, Please set product)
	$(call check_defined, command, Please set command)
	@ansible coreos -i inventory-$(product)/ ${PROXY_COMMAND} -m raw -a "$(command)" -f 10

# Compile python modules against homebrew openssl. The homebrew version provides a modern alternative to the one that comes packaged with OS X by default.
# OS X's older openssl version will fail against certain python modules, namely "cryptography"
# Taken from this git issue pyca/cryptography#2692
install-virtualenv-osx:
	ARCHFLAGS="-arch x86_64" LDFLAGS="-L/usr/local/opt/openssl/lib" CFLAGS="-I/usr/local/opt/openssl/include" pip install -r requirements.txt

decrypt_all:
	./decrypt_all.sh

encrypt_all:
	./encrypt_all.sh

pre_commit_install:
	cp git_hooks/pre-commit .git/hooks/pre-commit

tmux-provision:
	@ansible-playbook -vvv -i inventory-homelab/ bootstrap_office.yml --tags "tmux" -f 10

byobu-provision:
	@ansible-playbook -vvv -i inventory-homelab/ bootstrap_office.yml --tags "byobu" -f 10
