#!/bin/bash
dmd -O -release -inline -of=sdf-render *.d */*.d
