# Sequences that have been featured on Numberphile, but are not
# in the core sequences list.

use Math::Sequences::Integer :support, :DEFAULT;
use Math::Util::Roman;
use Math::Util::SpellNumbers;

### From: https://www.youtube.com/watch?v=OeGSQggDkxI

# A249572 - Least positive integer whose decimal digits divide the plane
# into n+1 regions. Otherwise read as the smallest positive integer that
# has n typographical holes in its digits.
# @ordering should contain the minimum, non-zero digit for each number of
# holes in its representation.
# $radix should contain the base to work in.
sub topologically-ordered-numbers(:@ordering=[<1 4 8>], :$radix=10) is export(:support) {
	lazy gather for 𝕀 -> $n {
		my $sum = 0;
		my $number = [~] reverse gather loop {
			my $order = min(@ordering.elems-1, $n-$sum);
			take @ordering[$order];
			$sum += $order;
			last if $sum == $n;
		};
		take parse-base($number, $radix);
	}
}

our @A249572 is export = topologically-ordered-numbers();

# A087409 - Multiples of 6 with digits grouped in pairs and leading
# zeros omitted.
sub digit-grouped-multiples(:$of, :$group=2) is export(:support) {
	lazy gather for ℕ.map({$^n * $of}) -> $multiple {
		state $accum = '';
		$accum ~= $multiple;
		if $accum.chars >= $group {
			take +$accum.substr(0,$group);
			$accum = $accum.substr($group);
		}
	}
}

our @A087409 is export = digit-grouped-multiples(:of(6), :group(2));

# A002904 - Delete all letters except c,d,i,l,m,v,x from n then read
# as Roman numeral if possible, otherwise 0.
our @A002904 is export = lazy gather for ℕ -> $n {
	my $name = as-words($n).subst(regex {<-[cdilmvx]>}, '', :i, :global);
	try {
		take from_roman($name);
		CATCH { when /'not valid'/ { take 0 }}
	}
}

# A006933 - 'Eban' numbers (the letter 'e' is banned!).
sub contains-letters($number, $letters) is export(:support){
	return as-words(+$number).comb.grep: * ~~ $letters;
}
our @A006933 is export = ℕ.grep: {not contains-letters($^n, <e>)};

# A006567 - Emirps (primes whose reversal is a different prime).
our @A006567 is export = ℕ.grep: {
	my $rebmun = $^n.flip;
	$^n.is-prime and $^n ne $rebmun and $rebmun.is-prime };

### From: https://www.youtube.com/watch?v=VDD6FDhKCYA

# Here's each sequence on the OEIS:
#Khintchine's constant: http://oeis.org/A002210
#Wieferich primes: http://oeis.org/A001220
#Golomb's sequence: http://oeis.org/A001462
#Largest metadrome in base n: http://oeis.org/A023811
#All 7's: http://oeis.org/A010727
#Wild Numbers: http://oeis.org/A058883

# Khintchine's constant does not have a spigot algorithm that
# is known, so the best we have right now is tables of known
# digits from fairly expensive computations.
# Source of these digits: http://oeis.org/A002210/b002210.txt
our @A002210 is export =
	2, 6, 8, 5, 4, 5, 2, 0, 0, 1, 0, 6, 5, 3, 0, 6, 4, 4, 5, 3, 0, 9, 7,
	1, 4, 8, 3, 5, 4, 8, 1, 7, 9, 5, 6, 9, 3, 8, 2, 0, 3, 8, 2, 2, 9, 3,
	9, 9, 4, 4, 6, 2, 9, 5, 3, 0, 5, 1, 1, 5, 2, 3, 4, 5, 5, 5, 7, 2, 1,
	8, 8, 5, 9, 5, 3, 7, 1, 5, 2, 0, 0, 2, 8, 0, 1, 1, 4, 1, 1, 7, 4, 9,
	3, 1, 8, 4, 7, 6, 9, 7, 9, 9, 5, 1, 5, 3, 4, 6, 5, 9, 0, 5, 2, 8, 8,
	0, 9, 0, 0, 8, 2, 8, 9, 7, 6, 7, 7, 7, 1, 6, 4, 1, 0, 9, 6, 3, 0, 5,
	1, 7, 9, 2, 5, 3, 3, 4, 8, 3, 2, 5, 9, 6, 6, 8, 3, 8, 1, 8, 5, 2, 3,
	1, 5, 4, 2, 1, 3, 3, 2, 1, 1, 9, 4, 9, 9, 6, 2, 6, 0, 3, 9, 3, 2, 8,
	5, 2, 2, 0, 4, 4, 8, 1, 9, 4, 0, 9, 6, 1, 8, 0, 6, 8, 6, 6, 4, 1, 6,
	6, 4, 2, 8, 9, 3, 0, 8, 4, 7, 7, 8, 8, 0, 6, 2, 0, 3, 6, 0, 7, 3, 7,
	0, 5, 3, 5, 0, 1, 0, 3, 3, 6, 7, 2, 6, 3, 3, 5, 7, 7, 2, 8, 9, 0, 4,
	9, 9, 0, 4, 2, 7, 0, 7, 0, 2, 7, 2, 3, 4, 5, 1, 7, 0, 2, 6, 2, 5, 2,
	3, 7, 0, 2, 3, 5, 4, 5, 8, 1, 0, 6, 8, 6, 3, 1, 8, 5, 0, 1, 0, 3, 2,
	3, 7, 4, 6, 5, 5, 8, 0, 3, 7, 7, 5, 0, 2, 6, 4, 4, 2, 5, 2, 4, 8, 5,
	2, 8, 6, 9, 4, 6, 8, 2, 3, 4, 1, 8, 9, 9, 4, 9, 1, 5, 7, 3, 0, 6, 6,
	1, 8, 9, 8, 7, 2, 0, 7, 9, 9, 4, 1, 3, 7, 2, 3, 5, 5, 0, 0, 0, 5, 7,
	9, 3, 5, 7, 3, 6, 6, 9, 8, 9, 3, 3, 9, 5, 0, 8, 7, 9, 0, 2, 1, 2, 4,
	4, 6, 4, 2, 0, 7, 5, 2, 8, 9, 7, 4, 1, 4, 5, 9, 1, 4, 7, 6, 9, 3, 0,
	1, 8, 4, 4, 9, 0, 5, 0, 6, 0, 1, 7, 9, 3, 4, 9, 9, 3, 8, 5, 2, 2, 5,
	4, 7, 0, 4, 0, 4, 2, 0, 3, 3, 7, 7, 9, 8, 5, 6, 3, 9, 8, 3, 1, 0, 1,
	5, 7, 0, 9, 0, 2, 2, 2, 3, 3, 9, 1, 0, 0, 0, 0, 2, 2, 0, 7, 7, 2, 5,
	0, 9, 6, 5, 1, 3, 3, 2, 4, 6, 0, 4, 4, 4, 4, 3, 9, 1, 9, 1, 6, 9, 1,
	4, 6, 0, 8, 5, 9, 6, 8, 2, 3, 4, 8, 2, 1, 2, 8, 3, 2, 4, 6, 2, 2, 8,
	2, 9, 2, 7, 1, 0, 1, 2, 6, 9, 0, 6, 9, 7, 4, 1, 8, 2, 3, 4, 8, 4, 7,
	7, 6, 7, 5, 4, 5, 7, 3, 4, 8, 9, 8, 6, 2, 5, 4, 2, 0, 3, 3, 9, 2, 6,
	6, 2, 3, 5, 1, 8, 6, 2, 0, 8, 6, 7, 7, 8, 1, 3, 6, 6, 5, 0, 9, 6, 9,
	6, 5, 8, 3, 1, 4, 6, 9, 9, 5, 2, 7, 1, 8, 3, 7, 4, 4, 8, 0, 5, 4, 0,
	1, 2, 1, 9, 5, 3, 6, 6, 6, 6, 6, 0, 4, 9, 6, 4, 8, 2, 6, 9, 8, 9, 0,
	8, 2, 7, 5, 4, 8, 1, 1, 5, 2, 5, 4, 7, 2, 1, 1, 7, 7, 3, 3, 0, 3, 1,
	9, 6, 7, 5, 9, 4, 7, 3, 8, 3, 7, 1, 9, 3, 9, 3, 5, 7, 8, 1, 0, 6, 0,
	5, 9, 2, 3, 0, 4, 0, 1, 8, 9, 0, 7, 1, 1, 3, 4, 9, 6, 2, 4, 6, 7, 3,
	7, 0, 6, 8, 4, 1, 2, 2, 1, 7, 9, 4, 6, 8, 1, 0, 7, 4, 0, 6, 0, 8, 9,
	1, 8, 2, 7, 6, 6, 9, 5, 6, 6, 7, 1, 1, 7, 1, 6, 6, 8, 3, 7, 4, 0, 5,
	9, 0, 4, 7, 3, 9, 3, 6, 8, 8, 0, 9, 5, 3, 4, 5, 0, 4, 8, 9, 9, 9, 7,
	0, 4, 7, 1, 7, 6, 3, 9, 0, 4, 5, 1, 3, 4, 3, 2, 3, 2, 3, 7, 7, 1, 5,
	1, 0, 3, 2, 1, 9, 6, 5, 1, 5, 0, 3, 8, 2, 4, 6, 9, 8, 8, 8, 8, 3, 2,
	4, 8, 7, 0, 9, 3, 5, 3, 9, 9, 4, 6, 9, 6, 0, 8, 2, 6, 4, 7, 8, 1, 8,
	1, 2, 0, 5, 6, 6, 3, 4, 9, 4, 6, 7, 1, 2, 5, 7, 8, 4, 3, 6, 6, 6, 4,
	5, 7, 9, 7, 4, 0, 9, 7, 7, 8, 4, 8, 3, 6, 6, 2, 0, 4, 9, 7, 7, 7, 7,
	4, 8, 6, 8, 2, 7, 6, 5, 6, 9, 7, 0, 8, 7, 1, 6, 3, 1, 9, 2, 9, 3, 8,
	5, 1, 2, 8, 9, 9, 3, 1, 4, 1, 9, 9, 5, 1, 8, 6, 1, 1, 6, 7, 3, 7, 9,
	2, 6, 5, 4, 6, 2, 0, 5, 6, 3, 5, 0, 5, 9, 5, 1, 3, 8, 5, 7, 1, 3, 7,
	6, 1, 6, 9, 7, 1, 2, 6, 8, 7, 2, 2, 9, 9, 8, 0, 5, 3, 2, 7, 6, 7, 3,
	2, 7, 8, 7, 1, 0, 5, 1, 3, 7, 6, 3, 9, 5, 6, 3, 7, 1, 9, 0, 2, 3, 1,
	4, 5, 2, 8, 9, 0, 0, 3, 0, 5, 8, 1, 3, 6, 9, 1, 0, 9, 0, 4, 7, 9, 9,
	6, 7, 2, 7, 5, 7, 5, 7, 1, 3, 8, 5, 0, 4, 3, 5, 6, 5, 0, 5, 0, 6, 4,
	1, 5, 9, 0, 8, 2, 0, 9, 9, 9, 6, 2, 3, 4, 0, 2, 7, 7, 9, 0, 5, 3, 8,
	3, 4, 1, 8, 0, 9, 8, 5, 1, 2, 1, 2, 7, 8, 5, 2, 9, 4, 5, 5, 4, 1, 5,
	1, 0, 1, 9, 2, 3, 2, 7, 3, 9, 7, 2, 7, 1, 6, 7, 9, 6, 8, 7, 5, 1, 5,
	6, 2, 4, 5, 5, 8, 6, 8, 7, 9, 7, 7, 1, 7, 5, 8, 7, 1, 8, 2, 6, 9, 3,
	6, 5, 9, 5, 5, 4, 5, 0, 2, 5, 1, 3, 0, 4, 1, 9, 6, 8, 1, 8, 6, 5, 0,
	9, 3, 8, 0, 3, 1, 3, 0, 3, 8, 5, 8, 4, 3, 5, 2, 9, 8, 6, 8, 6, 3, 6,
	3, 5, 1, 6, &Math::Sequences::Integer::NOSEQ ... *;

# A001220 - Wieferich primes: primes p such that p^2 divides 2^(p-1) - 1.
our @A001220 is export = ℕ.grep: -> $n { $n.is-prime and (2**($n-1)-1) %% ($n**2) };

# Golomb's sequence: http://oeis.org/A001462
proto golombs(Any) {*}
multi golombs(1) { 1 }
multi golombs($n) { 1 + golombs($n - golombs(golombs($n-1))) }

# A001462 - Golomb's sequence: a(n) is the number of times n occurs,
# starting with a(1) = 1
# NOTE: This sequence is already defined in Math::Sequences::Integer,
# but with a different algorithm, so I'm preserving this version
# here without exporting it by default, just for historical value.
our @alt-A001462 is export(:alt) = ℕ.map: -> $n {golombs($n) };

# A023811 - Largest metadrome (number with digits in strict ascending order)
# in base n.
our @A023811 is export = {
	(state $n = 0)++; [+] (^($n-1)).map: -> $i {$n**($n-$i-2) * ($i+1)}}...*;

# A010727 - All 7s
our @A010727 is export = 7 xx *;

# A058883 - The "Wild Numbers", from the novel of the same title (Version 1).
our @A058883 is export = 11, 67, 2, 4769, 67;

# From: https://www.youtube.com/watch?v=zk_Q9y_LNzg

#Beastly Primes: https://oeis.org/A131645
#Belphegor Primes: https://oeis.org/A232448
#Republican Primes: https://oeis.org/A125524
#Democratic Primes: https://oeis.org/A125523

# A131645 - Beastly primes (version 2): primes containing 666 as a
# substring.
#our @A131645 is export = @A000040.grep: * ~~ /666/;
our @A131645 is export = ℕ.map({$^n*2+1}).grep: {$^n ~~ /666/ and $^n.is-prime};

# A232448 - Belphegor primes: numbers n such that the decimal number
# 1 0...0(n zeros) 666 0...0(n zeros) 1 (i.e. A232449(n)) is prime.
our @A232448 is export = lazy 𝕀.grep: -> $n { "1{0 x $n}666{0 x $n}1".is-prime };

# A125524 - Republican primes: primes such that the right half of the prime
# is prime and the left half is not.
# Note: This was causing rakudo issues, so removed for now
# our @A125524 is export = lazy @A000040.grep: -> $p {
our @A125524 is export = lazy (1..*).grep(*.is-prime).grep: -> $p {
	!$p.substr(0,$p.chars div 2).is-prime and $p.substr(* - ($p.chars div 2)).is-prime
}

# A125523 - Democratic primes: primes such that the left half of the prime
# is prime and the right half is not.
# Note: This was causing rakudo issues, so removed for now
# our @A125523 is export = lazy @A000040.grep: -> $p {
our @A125523 is export = lazy (1..*).grep(*.is-prime).grep: -> $p {
	$p.substr(0,$p.chars div 2).is-prime and !$p.substr(* - ($p.chars div 2)).is-prime
}

# From: https://www.youtube.com/watch?v=etMJxB-igrc

# A181391 - Van Eck's sequence: For n>=1, if there exists an m < n such
# that a(m) = a(n), take the largest such m and set a(n+1) = n-m;
# otherwise a(n+1) = 0. Start with a(1)=0.
our @A181391 = 0, -> $prev {
	state %seen; (state $n = 0)++;
	my $next = %seen{$prev}:exists ?? $n-%seen{$prev} !! 0;
	%seen{$prev} = $n;
	$next;
} ... *;

# From: https://www.youtube.com/watch?v=cZkGeR9CWbk

#Lunar Primes: https://oeis.org/A087097
#Lunar Squares: https://oeis.org/A087019

sub lunar-add(+@nums) is export(:support) {
	+ flip [~] (roundrobin @nums.map({.flip.comb})).map: {.max}
}
sub lunar-mul($a, $b) is export(:support) {
	my @diga = $a.flip.comb;
	my @rows = gather for $b.flip.comb.kv -> $i, $d {
		take flip [~] gather do {
			take 0 for ^$i;
			for @diga -> $dd {
				take min($d, $dd);
			}
		}
	}
	lunar-add @rows;
}
our @A087019 is export = 𝕀.map: -> $n {lunar-mul $n, $n};

# A087097 - Lunar primes (formerly called dismal primes) (cf. A087062).
#our @A087097 is export =

# From: https://www.youtube.com/watch?v=RGQe8waGJ4w

proto spiral-board(Int, Bool :$flip, Int :$rotate) {*}
multi spiral-board(1) is export(:support) { [[1]] }
multi spiral-board(Int $size where * !%% 2) is export(:support) {
	my @prev = spiral-board $size - 2;
	my @cur = [ |^$size ] xx $size;
	# Insert the smaller square into the larger
	# This should have worked, I thought, but nope...
	# @cur[1 <<+<< ^@prev;1 <<+<< ^@prev] = @prev;
	for ^@prev -> $row {
		for ^@prev -> $col {
			@cur[$row+1;$col+1] = @prev[$row;$col];
		}
	}
	# Construct the outer edge index list
	my @outer = ($size**2) <<-<< ^($size**2 - ($size-2)**2);
	my @bottom = (^$size).reverse >>,>> ($size-1);
	my @left = 0 <<,<< (^($size-1)).reverse;
	my @top = (1..^$size) >>,>> 0;
	my @right = ($size-1) <<,<< (^($size-2))>>.succ;
	# And put it intp the outer edges
	for |@bottom, |@left, |@top, |@right -> ($x,$y) {
		@cur[$x;$y] = @outer.shift;
	}
	return @cur;
}
multi spiral-board(Int $size) is export(:support) { die "\$size must be odd" }
multi spiral-board(Int $size where * !%% 2, Bool :$flip, Int :$rotate=0) {
	my @board = spiral-board($size);
	if $flip {
		@board = @board>>.reverse;
	}
	for ^$rotate {
		@board = ((^$size).reverse).map: -> $y { @board[^$size;$y] };
	}
	@board
}

sub spiral-knight() {
	my @knight-moves = <1 2>, <1 -2>, <-1 2>, <-1 -2>, <2 1>, <2 -1>,
		<-2 1>, <-2 -1>;
	lazy gather loop {
		state $size = 5;
		state $x = 2; state $y = 2;
		state $sofar = SetHash.new: [1];
		state @board = spiral-board($size);
		while $x !~~ 2..^($size-2) or $y !~~ 2..^($size-2) {
			$size += 2;
			@board = spiral-board($size);
			$x++; $y++;
		}
		take @board[$x;$y];
		my @moves = eager @knight-moves.map(-> ($move-x, $move-y) {
			my $next = ($x + $move-x, $y + $move-y);
			$sofar{@board[$next[0];$next[1]]} ?? () !! $next;
		}).grep: *.elems;
		last if @moves.elems == 0;
		my $next = @moves.min(-> ($nx,$ny) {@board[$nx;$ny]});
		$x = $next[0];
		$y = $next[1];
		$sofar{@board[$next[0];$next[1]]}++;
	}
}

# A316667 - Squares visited by knight moves on a spirally numbered board
# and moving to the lowest available unvisited square at each step.
our @A316667 is export = spiral-knight;

#==========================================================
# Real digits
#==========================================================
#| Real digits
#| C<$x> -- number to convert.
#| C<:$base> -- conversion base.
#| C<:$n> -- digit exponent to start with.
#| C<:$tol> -- tolerance to stop the conversion with.
#| C<:$length> -- max number of digits.
proto sub real-digits(Numeric:D $x, *@args, *%args) is export {*}

multi sub real-digits($x, Numeric:D $b = 10, $n = Whatever, *%args) {
	return real-digits($x ~~ Int:D ?? $x.FatRat !! $x, :$b, :$n, |%args);
}

multi sub real-digits(Numeric:D $x is copy,
					  Numeric:D :base(:$b) = 10,
					  :start(:first-digit-exponent(:$n)) is copy = Whatever,
					  Numeric:D :tolerance(:$tol) = 10e-14,
					  :l(:len(:$length)) is copy = Inf) {
	if $x == 0 { return 0, 0}
	$x = abs($x);
	my @digits;
	my $current = $x;

	if $length.isa(Whatever) { $length = Inf }
	die 'The argument $length is expected to be a positive integer or Whatever.'
	unless ($length === Inf || $length ~~ Int:D) && $length > 0;

	if $n.isa(Whatever) { $n = $x.log($b).floor}
	die 'The third argument is expected to be a number or Whatever.' unless $n ~~ Numeric:D;

	if $x ~~ FatRat:D {
		my $exp = $n.FatRat;
		my $bf = $b.FatRat;

		my $bfe = [*] ($bf xx $exp);
		while $current / $x > $tol && @digits.elems < $length {
			#note (:$exp, power => $bf ** $exp, :$bfe);
			#note '$current / $bfe => ', $current / $bfe;
			my $r = $current / $bfe;
			my $digit = do if $r.round(10 ** -100) == 1 { 1 } else { ($current / $bfe).floor };
			@digits .= push($digit);
			#note (:$digit, '$digit.FatRat * $bfe => ', $digit.FatRat * $bfe);
			$current -= $digit.FatRat * $bfe;
			#note (:$current);
			$exp--;
			$bfe = $bfe / $bf;
		}
	} else {
		my $exp = $n;
		my $bf = $b;

		my $bfe = [*] ($bf xx $exp);
		while $current / $x > $tol && @digits.elems < $length {
			my $digit = floor($current / $bfe);
			@digits .= push($digit);
			$current -= $digit * $bfe;
			$exp--;
			$bfe = $bfe / $bf;
		}
	}

	return @digits, $n + 1;
}

#==========================================================
# Phi number system
#==========================================================
# Using N[Sqrt[5], 100] in Wolfram Language
constant $sqrt5 = 2.236067977499789696409173668731276235440618359611525724270897245410520925637804899414414408378782275.FatRat;

# Fibonacci 401 and 400
constant $fibonacci401 = 284812298108489611757988937681460995615380088782304890986477195645969271404032323901.FatRat;
constant $fibonacci400 = 176023680645013966468226945392411250770384383304492191886725992896575345044216019675.FatRat;

#| Golden ratio (phi)
our constant \phi is export = $fibonacci401 / $fibonacci400;
our constant \ϕ is export = $fibonacci401 / $fibonacci400;
#our constant \ϕ is export = (1.FatRat + $sqrt5) / 2.FatRat;

#| Phi number system.
#| C<$n> -- an integer number to convert.
#| C<:$tol> -- tolerance to stop the conversion with.
#| C<:$length> -- max number of digits.
sub phi-number-system(Int:D $n, Numeric:D :tolerance(:$tol) = 10e-16, :l(:len(:$length)) is copy = Whatever) is export {
	if $length.isa(Whatever) { $length = 2 * ($sqrt5 * abs($n)).log(ϕ).floor + 1; }
	my ($digits, $exp) = real-digits($n.FatRat, ϕ, :$tol, :$length);
	return $exp <<->> ($digits.grep(* == 1, :k) >>+>> 1);
}