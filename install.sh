

. lib


deps=( screenfetch xxxxx yyyy zzzzzz )

# Step 0 - Verify dependencies
dep_error_count=0
for dep in ${deps[@]}; do
	echo -ne "Checkin dependency $dep: "
	pacman -Q $dep >& /dev/null && echo -e "${GREEN}OK${NC}" || {
		t=$(( dep_error_count++ ))
		echo -e "${RED}Not found${NC}"
        }
done
if [ "$dep_error_count" -ne 0 ]; then
	echo -e "${RED}Total number of missing dependencies: $dep_error_count"
	echo -e "Aborting install - nothing was changed.${NC}"
	exit 0;
fi

# Step 1 - Generate issue for tty 1
gen_issue
gen_unit

# Step 2 - Configure agetty running on TTY1 to use the new issue file
conf_getty

# Step 3 - Enable issue-screenfetch.service
systemctl daemon-reload
systemctl enable issue-screenfetch.service
