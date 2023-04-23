# OUTCOME - zig-pkg support

[![Unit tests Zig (embedded)](https://github.com/kassane/outcome/actions/workflows/unittests_zig_embedded.yml/badge.svg?branch=zig-pkg)](https://github.com/kassane/outcome/actions/workflows/unittests_zig_embedded.yml)
[![Unit tests Zig](https://github.com/kassane/outcome/actions/workflows/unittests_zig.yml/badge.svg?branch=zig-pkg)](https://github.com/kassane/outcome/actions/workflows/unittests_zig.yml)
[![Unit tests Zig (msvc)](https://github.com/kassane/outcome/actions/workflows/unittests_zig_msvc.yml/badge.svg?branch=zig-pkg)](https://github.com/kassane/outcome/actions/workflows/unittests_zig_msvc.yml)

CTest dashboard: https://my.cdash.org/index.php?project=Boost.Outcome

All tests passing source tarballs: https://github.com/ned14/outcome/releases

Documentation: https://ned14.github.io/outcome/


## Purpose of this library

Outcome is a C++14 library for reporting and handling function failures. It can be used as a substitute for, or a complement to, the exception handling mechanism.

One use case is for contexts where using C++ exception handling is unsuitable for different reasons:

 * The high relative cost of throwing and catching a C++ exception.
 * Making some or all control paths explicitly detailed to aid code correctness auditing, as opposed to having hidden control paths caused by exceptions potentially thrown from any place.
 * Company policy to compile with exceptions disabled.
 * Maintaining a code base that was never designed with exception-safety in mind.
 * Parts of the programs/frameworks that themselves implement exception handling and cannot afford to use exceptions, like propagating failure reports across threads, tasks, fibers…


## Usage as a single header file

Outcome v2 comes in single header file form. This is regenerated per commit. To fetch
on Linux:

```
wget https://github.com/kassane/outcome/raw/develop/single-header/outcome.hpp
```

On BSD:

```
fetch https://github.com/kassane/outcome/raw/develop/single-header/outcome.hpp
```

If you have `curl` installed:

```
curl -O -J -L https://github.com/kassane/outcome/raw/develop/single-header/outcome.hpp
```

Otherwise, simply download the raw file from above and place it wherever it suits you.
If you might be debugging using Microsoft Visual Studio, you may find the debugger
visualisation file at https://github.com/kassane/outcome/raw/develop/include/outcome/outcome.natvis
useful to include into your build.

## Commits and tags in this git repository can be verified using:
<pre>
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

mDMEVvMacRYJKwYBBAHaRw8BAQdAp+Qn6djfxWQYtAEvDmv4feVmGALEQH/pYpBC
llaXNQe0WE5pYWxsIERvdWdsYXMgKHMgW3VuZGVyc2NvcmVdIHNvdXJjZWZvcmdl
IHthdH0gbmVkcHJvZCBbZG90XSBjb20pIDxzcGFtdHJhcEBuZWRwcm9kLmNvbT6I
eQQTFggAIQUCVvMacQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRCELDV4
Zvkgx4vwAP9gxeQUsp7ARMFGxfbR0xPf6fRbH+miMUg2e7rYNuHtLQD9EUoR32We
V8SjvX4r/deKniWctvCi5JccgfUwXkVzFAk=
=puFk
-----END PGP PUBLIC KEY BLOCK-----
</pre>

</center>
