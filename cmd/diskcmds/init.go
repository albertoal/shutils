package diskcmds

import (
	"fmt"

	"github.com/davecgh/go-spew/spew"
	"github.com/spf13/cobra"
)

var (
	parseShortDesc = `Prints examples of commands to operate on the disk`
	parseLongDesc  = `Prints examples of commands to operate on the disk`
	parseExample   = `
	### Available commands for operating on the disk
	shutils disk`
)

// Init instantiates the disk commands
func Init() *cobra.Command {
	cmd := &cobra.Command{
		Use:              "disk [no options!]",
		Short:            parseShortDesc,
		Long:             parseLongDesc,
		Example:          parseExample,
		TraverseChildren: true,
		Run: func(cmd *cobra.Command, args []string) {
			str := `
ls -lah # Display all files in current dir in human readable format
ls -ltr # Display files newest last
du -sh ~/**/* | sort -rn # Display dirs in sorted sizes
df -h # Display free disk space in human readable format
cat /proc/partitions # Display partitions
lsblk -f # Display block storage devices as a tree view. Should list the same partitions above.
mount | column -t # Get all mounted filesystems
cat /etc/fstab # Get the static file system info
free -m # Get free memory statistics for the system`
			fmt.Println(str)
			spew.Dump(str)
		},
	}

	return cmd
}
