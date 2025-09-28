package server_config

import (
	"fmt"
	"reflect"
	"strings"

	"github.com/RA341/gouda/pkg/argos"
	"github.com/goccy/go-yaml"
)

func GenerateYAMLWithComments(v interface{}) (string, error) {
	return GenerateYAMLWithCommentsIndent(v, 0)
}

func GenerateYAMLWithCommentsIndent(v interface{}, indentLevel int) (string, error) {
	val := reflect.ValueOf(v)
	typ := reflect.TypeOf(v)

	if val.Kind() == reflect.Ptr {
		val = val.Elem()
		typ = typ.Elem()
	}

	var result strings.Builder
	indent := strings.Repeat("  ", indentLevel) // 2 spaces per level

	for i := 0; i < val.NumField(); i++ {
		field := typ.Field(i)
		fieldValue := val.Field(i)

		// Skip unexported fields
		if !fieldValue.CanInterface() {
			continue
		}

		yamlTag := field.Tag.Get("yaml")
		if yamlTag == "" || yamlTag == "-" {
			continue
		}

		yamlName := yamlTag
		if commaIndex := strings.Index(yamlTag, ","); commaIndex != -1 {
			yamlName = yamlTag[:commaIndex]
		}

		confTags := argos.ParseTag(field.Tag.Get("config"))
		if confTags["usage"] != "" {
			result.WriteString(fmt.Sprintf("%s# %s\n", indent, confTags["usage"]))
		}

		if fieldValue.Kind() == reflect.Struct {
			// Nested struct
			result.WriteString(fmt.Sprintf("%s%s:\n", indent, yamlName))

			nestedYAML, err := GenerateYAMLWithCommentsIndent(fieldValue.Interface(), indentLevel+1)
			if err != nil {
				return "", err
			}
			result.WriteString(nestedYAML)
		} else {
			fieldMap := map[string]interface{}{
				yamlName: fieldValue.Interface(),
			}

			fieldYAML, err := yaml.Marshal(fieldMap)
			if err != nil {
				return "", err
			}

			// Add indentation to each line and remove the extra newline
			yamlLines := strings.Split(strings.TrimSpace(string(fieldYAML)), "\n")
			for _, line := range yamlLines {
				result.WriteString(fmt.Sprintf("%s%s\n", indent, line))
			}
		}

		// Add empty line for readability (except for last field)
		if i < val.NumField()-1 {
			result.WriteString("\n")
		}
	}

	return result.String(), nil
}
