package main

import (
	"errors"
	"fmt"
	"github.com/fatih/color"
	"github.com/goccy/go-yaml"
	"github.com/spf13/cobra"
	"golang.org/x/exp/maps"
	"log"
	"os"
	"strings"
)

var (
	red   = color.New(color.FgRed)
	green = color.New(color.FgGreen)

	printGreen = green.PrintlnFunc()
	greenF     = green.SprintfFunc()
	redF       = red.SprintfFunc()
	boldRedF   = red.Add(color.Bold).SprintfFunc()

	cyan = color.New(color.FgHiCyan).SprintfFunc()
)

func main() {
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
				must(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}

			printGreen("Building:", variant)
			printGreen("Output path:", outputPath)

			err := build(variant, outputPath)
			must(err)
		},
	}
	buildGouda.Flags().StringVarP(&outputPath, "out", "o", ".", "where to output the final build (default working directory)")

	return buildGouda
}

func goBuildCommands() *cobra.Command {
	allowedVariants := "[" + strings.Join(maps.Keys(variants), "|") + "]"

	var outputPath string
	var commit string
	var tag string
	var branch string

	goBuild := &cobra.Command{
		Use:   fmt.Sprintf("build %s", allowedVariants),
		Short: "go build commands that will run",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			path, err := GetCurrentModulePath()
			must(err)

			if path != "github.com/RA341/gouda" {
				must(fmt.Errorf(
					"gouda go module not found in current dir\nis there a go.mod with %s as its module name ?",
					goudaModuleName,
				))
				return
			}

			variant := args[0]
			if _, ok := variants[variant]; !ok {
				must(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}

			printGreen("Building variant", variant)
			if variant == "all" {
				must(fmt.Errorf(redF("Unsupported variant:", variant)))
			}
			if outputPath != "" {
				must(os.Mkdir(outputPath, os.ModePerm))
			}
			err = buildAndCopyGoBinary(
				outputPath,
				withVariant(variant),
				withSourceHash("."),
				withGitMetadata(GitInfo{Commit: commit, Branch: branch, Tag: tag}),
				withWorkingDir("."),
			)
			if err != nil {
				must(err)
			}
		},
	}
	goBuild.Flags().StringVarP(&outputPath, "out", "o", "", "where to output the final build (default working directory)")
	goBuild.Flags().StringVarP(&commit, "commit", "c", "unknown", "commit to use for the go build")
	goBuild.Flags().StringVarP(&tag, "tag", "t", "unknown", "tag to use for the go build")
	goBuild.Flags().StringVarP(&branch, "branch", "b", "unknown", "branch to for the go build")

	goHash := &cobra.Command{
		Use:   "hash",
		Short: "search and hash all *.go files recursively in the current directory",
		Run: func(cmd *cobra.Command, args []string) {
			hash, files, err := calculateGoSourceHash(goRoot)
			if err != nil {
				must(err)
			}
			printGreen("Hash:", hash, "\nFiles", files)
		},
	}

	goGit := &cobra.Command{
		Use:   "git",
		Short: "retrieve git metadata from repo",
		Run: func(cmd *cobra.Command, args []string) {
			_, err := getGitInfo()
			if err != nil {
				must(err)
			}
		},
	}

	mainCommand := &cobra.Command{
		Use:   "go",
		Short: "commands for the go builds",
	}

	mainCommand.AddCommand(goBuild)
	mainCommand.AddCommand(goHash)
	mainCommand.AddCommand(goGit)
	return mainCommand
}

func flutterBuildCommands() *cobra.Command {
	allowedVariants := "[" + strings.Join(maps.Keys(flutterVariants), "|") + "]"

	generalBuild := &cobra.Command{
		Use:   fmt.Sprintf("build %s", allowedVariants),
		Short: "flutter build commands",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			variant := args[0]
			if _, ok := flutterVariants[variant]; !ok {
				must(fmt.Errorf("invalid variant: %s, allowed: %s", args[0], allowedVariants))
			}
			fmt.Println(greenF("Building flutter variant: %s", variant))

			pubspecFile, err := os.Open("pubspec.yaml")
			if errors.Is(err, os.ErrNotExist) {
				must(fmt.Errorf("pubspec.yaml not found, make sure this is run in a valid flutter project"))
			}

			defer func() {
				warn(pubspecFile.Close())
			}()

			var pubspec map[string]interface{}
			must(yaml.NewDecoder(pubspecFile).Decode(&pubspec))
			pubName, ok := pubspec["name"].(string)
			if !ok {
				must(fmt.Errorf("pubspec.name not found"))
			}
			if pubName != "brie" {
				must(fmt.Errorf("invalid flutter project need name as brie"))
			}

			if _, err = buildFlutter(variant, ""); err != nil {
				must(err)
			}
		},
	}

	clean := &cobra.Command{
		Use:   "clean",
		Short: "clean flutter directories",
		Run: func(cmd *cobra.Command, args []string) {
			if err := runFlutterClean(); err != nil {
				must(err)
			}
		},
	}

	mainCommand := &cobra.Command{
		Use:   "flutter",
		Short: "commands for the flutter builds",
	}

	mainCommand.AddCommand(generalBuild)
	mainCommand.AddCommand(clean)
	return mainCommand
}
