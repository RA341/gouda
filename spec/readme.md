# Stubs

This folder contains all grpc stubs used in project

## Usage

Make sure to install the [requirements](#requirements)

To generate new stubs run:

```
just gen
```

this command will run the included dockerfile, run the code gen [script](gen-stubs.sh)

And copy the stubs to their respective directories

## Requirements

The project requires 

* Docker installed on your machine
* [Just cli](https://github.com/casey/just)
