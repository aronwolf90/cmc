#!/bin/bash

ifconfig eth0 | grep -Po "t addr:\K[\d.]+"
