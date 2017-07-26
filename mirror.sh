#!/bin/bash
export BLUE='\033[1;94m'
export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'

REPO="$2"
MASTER="$3"
SLAVE="$4"


function add {
	cd /storage/gitmirror
	git clone $MASTER
	cd $REPO
	git remote add slave $SLAVE
	git push -u slave --mirror
	echo repo: $REPO
	echo master:  $MASTER
	echo slave: $SLAVE
	exit 0
}

function sync {
	cd /storage/gitmirror
	cd $REPO
	git pull -u origin --all
	git push -u slave --mirror
	git pull -u slave --all
	git push -u origin --mirror
	exit 0
}

function syncall {
	exit 0
}


case "$1" in
	add)
		add
	;;
	sync)
		sync
	;;
	syncall)
		syncall
	;;
   	*)
echo -e "
Parrot Git Mirror (v 0.1)
	Developed by Lorenzo \"Palinuro\" Faletra <palinuro@parrotsec.org>
		and a huge amount of Caffeine + some GNU/GPL v3 stuff
	Usage:
	$RED┌──[$GREEN$USER$YELLOW@$BLUE`hostname`$RED]─[$GREEN$PWD$RED]
	$RED└──╼ \$$GREEN"" mirror $RED{$GREEN""add$RED|$GREEN""sync$RED""}

	$RED add <name> <git master> <git slave> $BLUE -$GREEN Add new git repo
	$RED sync <name>$BLUE -$GREEN synchronize a repository
	$RED syncall$BLUE -$GREEN synchronize all the repositories
$RESETCOLOR
Daicazzo!
" >&2

exit 1
;;
esac

echo -e $RESETCOLOR
exit 0
