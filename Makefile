# command name that are also directories
.PHONY:

#-----------------------------------------
# Allow passing arguments to make
#-----------------------------------------
SUPPORTED_COMMANDS := dev.up
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

#-----------------------------------------
# Help commands
#-----------------------------------------
.DEFAULT_GOAL := help

help: ## Prints this help
	@grep -E '^[a-zA-Z_\-\0.0-9]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean:
	@docker compose down --remove-orphans

dev: clean
	@docker compose up -d

dev.up:
	@docker compose up