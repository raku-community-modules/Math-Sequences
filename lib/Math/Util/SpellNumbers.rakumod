# Utilities for spelling out numbers as words

use Lingua::EN::Numbers;

sub as-words($number, :$lang='en') is export {
	&::('as-words-' ~ $lang)($number);
}

sub as-words-en($number) {
    die "Sorry, number is out of range: $number" if $number > 10e305;

    cardinal($number);
}

# vim: expandtab shiftwidth=4
