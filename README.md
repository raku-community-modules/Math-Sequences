[![Actions Status](https://github.com/raku-community-modules/Math-Sequences/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Math-Sequences/actions) [![Actions Status](https://github.com/raku-community-modules/Math-Sequences/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Math-Sequences/actions) [![Actions Status](https://github.com/raku-community-modules/Math-Sequences/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Math-Sequences/actions)

NAME
====

Math::Sequences - Various mathematical sequences of moderate use

SYNOPSIS
========

```raku
use Math::Sequences::Integer;  # You have to include one ...
use Math::Sequences::Real;     # ... or the other

say factorial(33);    # from  Math::Sequences::Integer;
say sigma( 8 );
say FatPi;

say ℝ.gist();         # from  Math::Sequences::Real;
say ℝ.from(pi)[0]
```

DESCRIPTION
===========

`Math::Sequences` is a module with integer and floating point sequences and some helper modules.

INCLUDED COMPONENTS
===================

Math::Sequences::Integer
------------------------

Integer sequences

### class Integers

Generic Integer sequences class

### class Naturals

More specific finite-starting-point class

### ℤ

The integers as a range

### 𝕀

The naturals (from 0) as a range

### ℕ

The naturals (from 1) as a range

### @AXXXXXX

All of the core OEIS sequences from [https://oeis.org/wiki/Index_to_OEIS:_Section_Cor](https://oeis.org/wiki/Index_to_OEIS:_Section_Cor)

### %oeis-core

A mapping of English names to sequences (e.g. `%oeis-core<primes>`.

### OEIS

A function that returns the sequence for a given name, but can also search for sequences (`.search` flag) whose names start with the given string, in which case a hash of name/sequence pairs is returned. Names can be the `%oeis-core` aliases or the OEIS key such as `A000001`.

Math::Sequences::Real
---------------------

Real sequences

### class Reals

Generic Real number sequences class

### ℝ

The reals as a range

Math::Sequences::Numberphile
----------------------------

OEIS sequences featured on the [Numberphile YouTube channel](https://youtube.com/numberphile).

### @AXXXXXX

As with `Math::Sequences::Integer`. these are exported by default and contain the sequence of values for that OEIS entry. They include:

    A001220 A002210 A002904 A006567 A006933 A010727 A023811
    A058883 A087019 A087409 A125523 A125524 A131645 A181391
    A232448 A249572 A316667

### topologically-ordered-numbers(:@ordering=[<1 4 8>], :$radix=10)

A generator for "holey" numbers.

### digit-grouped-multiples(:$of, :$group=2)

A generator for sequences of numbers that are generated by taking the multiplication table for the given `:$of` value and grouping the resulting digits in groups of `:$group` which results in a new sequence.

### contains-letters($number, $letters)

A test that returns true if the words for `$number` (e.g. "one thousand four hundred five") contain the given `$letters`.

### spiral-board(Int $size, Bool :$flip, Int :$rotate=0)

Returns a list of lists containing a spiral numbering sequence starting from the geometric middle of the square and spiraling out to fill it. This is used by `@A316667`. The optional flip and rotate parameters can be used to modify the orientation of the resulting board.

SUPPORT ROUTINES
================

These routines and operators are defined to support the definition of the sequences. Because they're not the primary focus of this library, they may be moved out into some extrnal library in the future...

Integer support routines
------------------------

To gain access to these, use:

```raku
use Math::Sequences::Integer :support;
```

### $a choose $b

(binomial) The choose and ichoose (for integer-only results) infix operators return the binomial coefficient on the inputs.

### binpart($n)

The binary partitions of n.

### Entringer($n, $k)

Alternating permutation (or zigzag permutation) of the set 1 through n, taken k at a time, where each is an arrangement that is alternately greater or less than the preceding.

### Eulers-number($terms)

Returns digits of e to terms places after the decimal as a FatRat.

### factorial($n)

The factorial of n.

### factors($n, :%map)

The prime factors (non-unique) of n. Takes an optional map of inputs to results, mostly used to deal with the ambiguous factors of 0 and 1.

### divisors($n)

The unique list of whole divisors of n. e.g. `divisors(6)` gives `(1, 2, 3, 6)`.

### moebius($n)

The Möbius number of n.

### sigma($n, $exponent=1)

The sum of positive divisors function σ. The optional exponent is the power to which each divisor is raised before summing.

### Sterling1($n, $k)

Count permutations according to their number of cycles.

### Sterling2($n, $k)

The number of ways to partition a set of n objects into k non-empty subsets.

### totient($n)

The numbers from zero to n that are co-prime to n.

### planar-partitions($n)

The planar partitions of n. See: [https://mathworld.wolfram.com/PlanePartition.html](https://mathworld.wolfram.com/PlanePartition.html).

### strict-partitions($n)

The strict partitions of _n_ are the ways that _n_ can be generated by summing unique positive, non-zero integers. See: [https://math.stackexchange.com/questions/867760/what-is-the-count-of-the-strict-partitions-of-n-in-k-parts-not-exceeding-m](https://math.stackexchange.com/questions/867760/what-is-the-count-of-the-strict-partitions-of-n-in-k-parts-not-exceeding-m)

### Pi-digits

A generator of digits for pi. Relatively fast and very memory-efficient.

### FatPi($digits=100)

This function is certainly going to be moved out of this library at some point, as it is not used here and doesn't return an integer, but it's a simple wrapper around Pi-digits which returns a `FatRat` rational for pi to the given number of digits. e.g. `FatPi(17).nude` gives: `(7853981633974483 2500000000000000)`.

ABOUT UNICODE
=============

This library uses a few non-ASCII Unicode characters that are widely used within the mathematical community. They are entirely optional, however, and if you wish to use their ASCII equivalents this table will help you out:

(the following assume `use Math::Sequences::Integer; use Math::Sequences::Real;`.

  * ℤ - Integers.new

  * 𝕀 - Naturals.new.from(0) or simply Naturals.new

  * ℕ - Naturals.new.from(1)

  * ℝ - Reals.new

The following, respectively, are defined 'ASCII equivalent' constants for each of the above:

  * Z

  * I

  * N

  * R

Entering symbols
----------------

To enter each of these Unicode symbols, here are common shortcuts in vim and emacs:

### ℤ - DOUBLE-STRUCK CAPITAL Z - U+2124

  * vim - Ctrl-v u 2 1 2 4

  * emacs - Ctrl-x 8 `enter` 2 1 2 4 `enter`

### 𝕀 - MATHEMATICAL DOUBLE-STRUCK CAPITAL I - U+1D540

  * vim - Ctrl-v U 0 0 0 1 d 5 4 0

  * emacs - Ctrl-x 8 `enter` 1 d 5 4 0 `enter`

### ℕ - DOUBLE-STRUCK CAPITAL N - U+2115

  * vim - Ctrl-v u 2 1 1 5

  * emacs - Ctrl-x 8 `enter` 2 1 1 5 `enter`

### ℝ - DOUBLE-STRUCK CAPITAL R - U+211D

  * vim - Ctrl-v u 2 1 1 d

  * emacs - Ctrl-x 8 `enter` 2 1 1 d `enter`

EXAMPLES
========

See the [examples](./examples) directory for usage.

AUTHORS
=======

  * Aaron Sherman

  * JJ Merelo

COPYRIGHT AND LICENSE
=====================

Copyright 2016 - 2019 Aaron Sherman

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

