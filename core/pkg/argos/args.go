package argos

import (
	"flag"
	"fmt"
	"os"
	"reflect"
	"strconv"
	"strings"
)

// Scan uses reflection to iterate over the fields of a struct,
// read the 'config' tags, and set up the corresponding flags.
// and populates it from defaults, environment variables,
// and command-line flags, and then parses the flags.
//
// The order of precedence is:
//
// 1. Command-line flags (e.g., -port 9000)
// 2. Environment variables (e.g., DOCKMAN_PORT=9000)
// 3. Values set in the provided struct.
// 4. Default values specified in struct tags.
func Scan(s interface{}, envPrefix string) error {
	// Ensure we have a pointer to a struct
	val := reflect.ValueOf(s)
	if val.Kind() != reflect.Ptr || val.Elem().Kind() != reflect.Struct {
		return fmt.Errorf("expected a pointer to a struct")
	}

	// Get the struct element that the pointer points to
	structVal := val.Elem()
	structType := structVal.Type()

	// Iterate over each field of the struct
	for i := 0; i < structVal.NumField(); i++ {
		fieldVal := structVal.Field(i)
		fieldType := structType.Field(i)

		// Skip unexported fields
		if !fieldVal.CanSet() {
			continue
		}

		tag, ok := fieldType.Tag.Lookup("config")
		if !ok {
			continue // Skip fields without the config tag
		}

		if fieldType.Type.Kind() == reflect.Struct {
			err := Scan(fieldVal.Addr().Interface(), envPrefix)
			if err != nil {
				return err
			}
			continue
		}

		tags := ParseTag(tag)

		fieldName := fieldType.Name
		var defaultValue string
		var err error
		// if zero val use the default from tags or use the set value
		if fieldVal.IsZero() {
			defaultValue, err = loadDefault(tags)
			if err != nil {
				return fmt.Errorf("unable to load default val for field '%s': %w", fieldName, err)
			}
		} else {
			defaultValue, err = convertToString(fieldVal)
			if err != nil {
				return fmt.Errorf("unable to convert field '%s' to string: %w", fieldName, err)
			}
		}

		// Determine the effective default value
		// environment variable overrides default
		if envVal, ok := loadEnv(tags, envPrefix); ok {
			defaultValue = envVal
		}

		if err = setFlag(fieldVal, fieldType.Name, tags, defaultValue); err != nil {
			return err
		}
	}
	return nil
}

func setFlag(fieldVal reflect.Value, fieldName string, tags map[string]string, defaultValue string) error {
	flagName, ok := tags["flag"]
	if !ok {
		return fmt.Errorf("field: %s, does not have a `flag` tag", fieldName)
	}
	usage := tags["usage"]

	// Set the flag based on the field's type
	fieldPtr := fieldVal.Addr().Interface()
	switch fieldVal.Kind() {
	case reflect.String:
		flag.StringVar(fieldPtr.(*string), flagName, defaultValue, usage)
	case reflect.Int:
		defaultInt, err := strconv.Atoi(defaultValue)
		if err != nil {
			return fmt.Errorf("invalid integer default for %s: %w", fieldName, err)
		}
		flag.IntVar(fieldPtr.(*int), flagName, defaultInt, usage)
	case reflect.Bool:
		defaultBool, err := strconv.ParseBool(defaultValue)
		if err != nil {
			return fmt.Errorf("invalid boolean default for %s: %w", fieldName, err)
		}
		flag.BoolVar(fieldPtr.(*bool), flagName, defaultBool, usage)
	default:
		return fmt.Errorf("unsupported field type for configuration: %s", fieldVal.Kind())
	}

	return nil
}

func loadEnv(tags map[string]string, envPrefix string) (string, bool) {
	env, ok := tags["env"]
	if !ok {
		return "", false
	}
	envName := fmt.Sprintf("%s_%s", envPrefix, env)

	return os.LookupEnv(envName)
}

func loadDefault(tags map[string]string) (string, error) {
	defaultValue, ok := tags["default"]
	if !ok {
		return "", fmt.Errorf("empty default value, set 'default' tag")
	}
	return defaultValue, nil
}

// ParseTag splits a struct tag into a key-value map.
// e.g., `flag=port,env=PORT` becomes `map[string]string{"flag": "port", "env": "PORT"}`
func ParseTag(tag string) map[string]string {
	result := make(map[string]string)
	parts := strings.Split(tag, ",")
	for _, part := range parts {
		kv := strings.SplitN(part, "=", 2)
		if len(kv) == 2 {
			result[strings.TrimSpace(kv[0])] = strings.TrimSpace(kv[1])
		}
	}
	return result
}

// Helper function to convert reflect.Value to string safely
func convertToString(v reflect.Value) (string, error) {
	if !v.IsValid() {
		return "", fmt.Errorf("invalid value")
	}

	switch v.Kind() {
	case reflect.String:
		return v.String(), nil
	case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
		return strconv.FormatInt(v.Int(), 10), nil
	case reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
		return strconv.FormatUint(v.Uint(), 10), nil
	case reflect.Float32, reflect.Float64:
		return strconv.FormatFloat(v.Float(), 'f', -1, 64), nil
	case reflect.Bool:
		return strconv.FormatBool(v.Bool()), nil
	case reflect.Ptr:
		if v.IsNil() {
			return "<NIL pointer>", nil
		}
		return convertToString(v.Elem())
	case reflect.Interface:
		if v.IsNil() {
			return "<NIL pointer>", nil
		}
		return convertToString(v.Elem())
	default:
		// For other types, use fmt.Sprintf
		return fmt.Sprintf("%v", v.Interface()), nil
	}
}
