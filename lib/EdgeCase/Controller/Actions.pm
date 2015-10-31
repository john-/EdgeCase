package EdgeCase::Controller::Actions;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

sub base {
    my $self = shift;

    $self->render(template => 'base');
}

sub execute {
    my $self = shift;

    my $output;
    if ($self->param('random')) {
        my $actual_count = $self->mpd->random($self->param('count'));
        $self->mpd->play;     
        if ($actual_count) {
            $output = sprintf('Added %s random songs', $actual_count);
        }
        $self->stash(message => $output);
    } elsif ($self->param('play')) {
        $self->mpd->play;     
    } elsif ($self->param('pause')) {
        $self->mpd->pause;     
    } elsif ($self->param('skip')) {
        $self->mpd->next;     
    } elsif ($self->param('volup')) {
        my $actual_vol = $self->mpd->volume('up');
        if ($actual_vol) {
            $output = sprintf('Volume is now %s', $actual_vol);
        }
        $self->stash(message => $output);
    } elsif ($self->param('voldown')) {
        my $actual_vol = $self->mpd->volume('down');
        if ($actual_vol) {
            $output = sprintf('Volume is now %s', $actual_vol);
        }
        $self->stash(message => $output);
    }

    $self->render(template => 'base');
}

1;
