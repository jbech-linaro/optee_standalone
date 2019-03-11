# OP-TEE standalone
For the moment it's a bit messy to do standalone builds in OP-TEE, especially
when it comes to `optee_test`. This little toy project shows how one can build
it with no other dependencies. This relates to issue:
https://github.com/OP-TEE/optee_test/issues/334

**Note!** This is **NOT** meant to replace official instructions or anything like
that. It's more a reminder to how it can be done, meanwhile it's a mess in the
official tree.

**Note!** This disables some tests in `xtest`, since we disable "mbed TLS" (and
thereby get rid of the OpenSSL dependency).

## Get the source
```bash
    $ git clone https://github.com/jbech-linaro/optee_standalone
    $ cd optee_standalone
    $ git submodule init
    $ git submodule update
```

## Build
```bash
    $ make
```
