use Math::Sequences::Integer :support, :DEFAULT;

#| Give the closest prime number to the given integer.
sub MAIN(Int $n) {
	for @A000040 -> $prime {
		state $prev = Nil;
		if $prime >= $n {
			if $prev and abs($n-$prev) < abs($n-$prime) {
				say $prev;
			} else {
				say $prime;
			}
			last;
		}
		$prev = $prime;
	}
}

# vim: expandtab shiftwidth=4
