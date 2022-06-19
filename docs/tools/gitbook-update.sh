#!/bin/bash

gitbook init

gitbook build . docs

gitbook serve . docs
