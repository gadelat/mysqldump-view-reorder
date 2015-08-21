#!/usr/bin/env perl

use List::MoreUtils 'first_index'; #apt package liblist-moreutils-perl
use strict;
use warnings;


my $views_sql;

while (<>) {
	$views_sql .= $_ if $views_sql or index($_, 'Final view structure') != -1;
	print $_ if !$views_sql;
}

my @views_regex_result = ($views_sql =~ /(\-\- Final view structure.+?\n\-\-\n\n.+?\n\n)/msg);
my @views = (join("", @views_regex_result) =~ /\-\- Final view structure for view `(.+?)`/g);
my $new_views_section = "";
while (@views) {
	foreach my $view (@views_regex_result) {
		my $view_body = ($view =~ /\/\*.+?VIEW .+ AS (select .+)\*\/;/g )[0];
		my $found = 0;
		foreach my $view (@views) {
			if ($view_body =~ /(from|join)[ \(]+`$view`/) {
				$found = $view;
				last;
			}
		}
		if (!$found) {
			print $view;
			my $name_of_view_which_was_not_found = ($view =~ /\-\- Final view structure for view `(.+?)`/g)[0];
			my $index = first_index { $_ eq $name_of_view_which_was_not_found } @views;
			if ($index != -1) {
				splice(@views, $index, 1);
				splice(@views_regex_result, $index, 1);
			}
		}
	}
}