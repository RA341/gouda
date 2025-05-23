package main

import (
	"fmt"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"golang.org/x/exp/maps"
	"log"
	"strings"
)

var (
	red   = color.New(color.FgRed)
	green = color.New(color.FgGreen)

	greenF   = green.SprintfFunc()
	redF     = red.SprintfFunc()
	boldRedF = red.Add(color.Bold).SprintfFunc()

	cyan = color.New(color.FgHiCyan).SprintfFunc()
)

func main() {
	err := resolveRootDir()
	if err != nil {
		cmdError(err)
	}

	var rootCmd = &cobra.Command{
		Use:   "goub",
		Short: "Build tool for gouda",
	}

	rootCmd.AddCommand(goBuildCommands())
	rootCmd.AddCommand(flutterBuildCommands())
	rootCmd.AddCommand(generalBuildCommands())

	if err := rootCmd.Execute(); err != nil {
		log.Fatal(err)
	}
}

func generalBuildCommands() *cobra.Command {
	allowedVariants := "[" + strings.Join(maps.Keys(variants), "|") + "]"

	var outputPath string
	buildGouda := &cobra.Command{
		Use:   fmt.Sprintf("build %s", allowedVariants),
		Short: "build commands to package apps",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			variant := args[0]
			if _, ok := variants[variant]; !ok {
				cmdError(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}
			fmt.Println(greenF("Building: %s", variant))
			if variant == "all" {
				//cmd1, _ := goBuildCmd(withDefault(), withVariant("server"))
				//cmd2, _ := goBuildCmd(withDefault(), withVariant("desktop"))

				//fmt.Println(cyan("Command:\n%s", strings.Join(cmd1, "\n")))
				//fmt.Println()
				//fmt.Println(cyan("Command:\n%s", strings.Join(cmd2, "\n")))
				fmt.Println(greenF("Building all packages"))
				return
			}

			err := build(variant, outputPath, withDefault(), withVariant(variant))
			cmdError(err)
		},
	}
	outputPath = *buildGouda.Flags().StringP("out", "o", ".", "where to output the final build")

	return buildGouda
}

func goBuildCommands() *cobra.Command {
	allowedVariants := "[" + strings.Join(maps.Keys(variants), "|") + "]"

	goBuild := &cobra.Command{
		Use:   fmt.Sprintf("build %s", allowedVariants),
		Short: "go build commands that will run",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			variant := args[0]
			if _, ok := variants[variant]; !ok {
				cmdError(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}

			fmt.Println(greenF("Building variant: %s", variant))
			if variant == "all" {
				//cmd1, _ := goBuildCmd(withDefault(), withVariant("server"))
				//cmd2, _ := goBuildCmd(withDefault(), withVariant("desktop"))
				//
				//fmt.Println(cyan("Command:\n%s", strings.Join(cmd1, "\n")))
				//fmt.Println()
				//fmt.Println(cyan("Command:\n%s", strings.Join(cmd2, "\n")))
				return
			}

			_, err := runGoBuild(withDefault(), withVariant(variant))
			if err != nil {
				cmdError(err)
			}
		},
	}

	goHash := &cobra.Command{
		Use:   "hash",
		Short: "search and hash all *.go files recursively in the current directory",
		Run: func(cmd *cobra.Command, args []string) {
			hash, files, err := calculateGoSourceHash(goRoot)
			if err != nil {
				cmdError(err)
			}
			fmt.Println(greenF("Hash: %s\nFiles: %d", hash, files))
		},
	}

	mainCommand := &cobra.Command{
		Use:   "go",
		Short: "commands for the go builds",
	}

	mainCommand.AddCommand(goBuild)
	mainCommand.AddCommand(goHash)
	return mainCommand
}

func flutterBuildCommands() *cobra.Command {
	allowedVariants := "[" + strings.Join(maps.Keys(flutterVariants), "|") + "]"

	build := &cobra.Command{
		Use:   fmt.Sprintf("build %s", allowedVariants),
		Short: "flutter build commands",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			variant := args[0]
			if _, ok := flutterVariants[variant]; !ok {
				cmdError(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}
			fmt.Println(greenF("Building flutter variant: %s", variant))

			if _, err := runFlutterBuild(variant); err != nil {
				cmdError(err)
			}
		},
	}

	clean := &cobra.Command{
		Use:   "clean",
		Short: "clean flutter directories",
		Run: func(cmd *cobra.Command, args []string) {
			if err := runFlutterClean(); err != nil {
				cmdError(err)
			}
		},
	}

	mainCommand := &cobra.Command{
		Use:   "flutter",
		Short: "commands for the flutter builds",
	}

	mainCommand.AddCommand(build)
	mainCommand.AddCommand(clean)
	return mainCommand
}
