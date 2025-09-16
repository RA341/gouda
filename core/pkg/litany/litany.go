package litany

import (
	"fmt"
	"math/rand/v2"
	"strings"
)

const (
	width      = 90
	colorReset = "\033[0m"
	// Nord color palette ANSI equivalents
	nord4  = "\033[38;5;188m" // Snow Storm (darkest) - main text color
	nord8  = "\033[38;5;110m" // Frost - light blue
	nord9  = "\033[38;5;111m" // Frost - blue
	nord10 = "\033[38;5;111m" // Frost - deep blue
	nord15 = "\033[38;5;139m" // Aurora - purple
)

const EqualDividerLabel = "EqualDivider"
const DashDividerLabel = "DashDivider"

// FieldFormatter formats with a specific printer
type FieldFormatter func(string) string

// TimeFormatter calls formatTime for a human-readable time
//
// e.g. 2006-01-02 3:04 PM MST (8 hours ago)
func TimeFormatter(input string) string {
	return formatTime(input)
}

type Field struct {
	label     string
	value     string
	Formatter FieldFormatter
}

type FieldConfig struct {
	fields []Field
}

func NewFieldConfig() FieldConfig {
	return FieldConfig{}
}

func (conf *FieldConfig) NewStrField(label, value string) {
	conf.add(Field{
		label: label,
		value: value,
	})
}

// NewGithubMetadata adds GitHub repository metadata fields to the configuration.
// It creates adds 3 string fields containing repository information:
//   - "Repo": The repository URL (e.g., "https://github.com/user/repo")
//   - "Branch": A clickable URL to the specific branch (repo/tree/branch)
//   - "Commit": A clickable URL to the specific commit (repo/commit/commit)
func (conf *FieldConfig) NewGithubMetadata(repo, commit, branch string) {
	branchURL := fmt.Sprintf("%s/tree/%s", repo, branch)
	commitURL := fmt.Sprintf("%s/commit/%s", repo, commit)

	conf.NewStrField("Repo", repo)
	conf.NewStrField("Branch", branchURL)
	conf.NewStrField("Commit", commitURL)
}

func (conf *FieldConfig) NewTimeField(label, value string) {
	conf.add(Field{
		label:     label,
		value:     value,
		Formatter: TimeFormatter,
	})
}

func (conf *FieldConfig) DashDivider() {
	conf.add(Field{label: DashDividerLabel})
}

func (conf *FieldConfig) EqualDivider() {
	conf.add(Field{label: EqualDividerLabel})
}

func (conf *FieldConfig) add(field Field) {
	conf.fields = append(conf.fields, field)
}

func Announce(headers []string, vars FieldConfig) {
	equalDivider := nord9 + strings.Repeat("=", width) + colorReset
	dashDivider := nord10 + strings.Repeat("-", width) + colorReset

	fmt.Println(equalDivider)
	fmt.Printf("%s%s %s %s\n", nord15, strings.Repeat(" ", (width-24)/2), headers[rand.IntN(len(headers))], colorReset)
	fmt.Println(equalDivider)

	// Print app info with aligned values
	printField := func(name, value string) {
		fmt.Printf("%s%-15s: %s%s%s\n", nord4, name, nord8, value, colorReset)
	}

	for _, conf := range vars.fields {
		if conf.label == EqualDividerLabel {
			fmt.Println(equalDivider)
			continue
		}

		if conf.label == DashDividerLabel {
			fmt.Println(dashDivider)
			continue
		}

		if conf.Formatter != nil {
			printField(conf.label, conf.Formatter(conf.value))
			continue
		}

		printField(conf.label, conf.value)
	}
}
