FROM archlinux:latest

RUN echo 'root:root' | chpasswd && yes | pacman -Syu | pacman -Sy zsh git sudo base-devel vim

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) && echo '/bin/zsh' | chsh root"

RUN groupadd -g 1000 sfoes
RUN useradd -d /home/sfoes -m sfoes -u 1000 -g 1000
RUN echo "sfoes:sfoes" | chpasswd
RUN usermod -a -G wheel sfoes
RUN echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

USER sfoes
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) && echo -e 'sfoes\n/bin/zsh\n' | chsh sfoes"

ENTRYPOINT ["tail", "-f", "/dev/null"]
