#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use UMS;
use RESTUMS;
use Plack::Builder;
#RESTUMS->to_app;
#UMS->to_app;
builder {
    mount '/'    => UMS->to_app;
    mount '/RESTUMS' => UMS::RESTUMS->to_app;
};
