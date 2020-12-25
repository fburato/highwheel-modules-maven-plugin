# Preamble 
SHELL := bash 
.ONESHELL: 
.SHELLFLAGS := -eu -o pipefail -c 
.DELETE_ON_ERROR: 
MAKEFLAGS += --warn-undefined-variables 
MAKEFLAGS += --no-builtin-rules

# Project 
SHELL:=/bin/bash
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PYTHON_LIB=$(shell find $(ROOT_DIR)/.venv/lib -name site-packages)
pipenv_exec:=$(shell which pipenv)
pipenv=PIPENV_VENV_IN_PROJECT=true $(pipenv_exec)

release:
	mvn -Prelease-sign-artifacts clean release:clean release:perform
