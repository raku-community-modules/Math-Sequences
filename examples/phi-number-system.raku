#!/usr/bin/env raku
use v6.d;

use Math::Sequences::Numberphile;

# 32
my $n = 32;
#my @res = phi-number-system($n, tol => 10e-12, :40length);
my @res = phi-number-system($n);

say (:$n, :@res);

say @res.map({ ϕ ** $_ }).sum.round(10e-11);

## 2025
$n = 2025;
@res = phi-number-system($n);

say (:$n, :@res);

say @res.map({ ϕ ** $_ }).sum.round(10e-11);
