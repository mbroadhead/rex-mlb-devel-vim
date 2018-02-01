package Rex::MLB::Devel::Vim;

use Rex -base;
use Rex::Helper::Path;

task setup => sub {
   install_vim();
   install_vimrc();
};

task install_vimrc => sub {
    needs 'install_vim_plug';
    file resolv_path('~/.vimrc'), source => 'templates/vimrc';
    run 'vim +PlugInstall +qall';
};

task install_vim => sub {
    Rex::Commands::Run::sudo(
        sub {
            run 'id';
            run 'whoami';
            pkg 'vim', ensure => 'latest';
        }
    );
};

task install_vim_plug => sub {
    run qq{curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim};
};

1;

=pod

=head1 NAME

Rex::MLB::Devel::Vim - Install and configure vim to MLB's liking

=head1 DESCRIPTION

Install and configure vim to MLB's liking

=head1 USAGE


 include qw/Rex::MLB::Devel::Vim/;

 task yourtask => sub {
    Rex::MLB::Devel::Vim::setup();
 };

=head1 TASKS

=over 4

=item setup

Execute L</install_vim>, L</install_vimrc>

=item install_vimrc

Install the vimrc to ~/.vimrc

=item install_vim

Install vim

=item set_dark

Set the background to dark in ~/.vimrc

=item set_light

Set the background to light in ~/.vimrc

=back

=cut
