package info

import (
	"fmt"
	"math/rand/v2"
	"os"
	"path/filepath"
	"strings"
)

// build args to modify vars
//
// go build -ldflags "\
//  -X github.com/RA341/gouda/internal/info.Version=0.1.0 \
//  -X github.com/RA341/gouda/internal/info.CommitInfo=$(git rev-parse HEAD) \
//  -X github.com/RA341/gouda/internal/info.BuildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
//  -X github.com/RA341/gouda/internal/info.Branch=$(git rev-parse --abbrev-ref HEAD) \
//  "
// cmd/server.go

func PrintInfo() {
	// generated from https://patorjk.com/software/taag/#p=testall&f=Graffiti&t=gouda
	var headers = []string{
		// contains some characters that mess with multiline strings leave this alone
		"\n                                _(`-')    (`-')  _  \n    .->        .->        .->  ( (OO ).-> (OO ).-/  \n ,---(`-')(`-')----. ,--.(,--.  \\    .'_  / ,---.   \n'  .-(OO )( OO).-.  '|  | |(`-')'`'-..__) | \\ /`.\\  \n|  | .-, \\( _) | |  ||  | |(OO )|  |  ' | '-'|_.' | \n|  | '.(_/ \\|  |)|  ||  | | |  \\|  |  / :(|  .-.  | \n|  '-'  |   '  '-'  '\\  '-'(_ .'|  '-'  / |  | |  | \n `-----'     `-----'  `-----'   `------'  `--' `--' \n",
		"\n     ,o888888o.        ,o888888o.     8 8888      88 8 888888888o.            .8.          \n    8888     `88.   . 8888     `88.   8 8888      88 8 8888    `^888.        .888.         \n ,8 8888       `8. ,8 8888       `8b  8 8888      88 8 8888        `88.     :88888.        \n 88 8888           88 8888        `8b 8 8888      88 8 8888         `88    . `88888.       \n 88 8888           88 8888         88 8 8888      88 8 8888          88   .8. `88888.      \n 88 8888           88 8888         88 8 8888      88 8 8888          88  .8`8. `88888.     \n 88 8888   8888888 88 8888        ,8P 8 8888      88 8 8888         ,88 .8' `8. `88888.    \n `8 8888       .8' `8 8888       ,8P  ` 8888     ,8P 8 8888        ,88'.8'   `8. `88888.   \n    8888     ,88'   ` 8888     ,88'     8888   ,d8P  8 8888    ,o88P' .888888888. `88888.  \n     `8888888P'        `8888888P'        `Y88888P'   8 888888888P'   .8'       `8. `88888. \n",
		`
 ██████╗  ██████╗ ██╗   ██╗██████╗  █████╗ 
██╔════╝ ██╔═══██╗██║   ██║██╔══██╗██╔══██╗
██║  ███╗██║   ██║██║   ██║██║  ██║███████║
██║   ██║██║   ██║██║   ██║██║  ██║██╔══██║
╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██║  ██║
 ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝ 
`,
		`
                                    $$\           
                                    $$ |          
 $$$$$$\   $$$$$$\  $$\   $$\  $$$$$$$ | $$$$$$\  
$$  __$$\ $$  __$$\ $$ |  $$ |$$  __$$ | \____$$\ 
$$ /  $$ |$$ /  $$ |$$ |  $$ |$$ /  $$ | $$$$$$$ |
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$  __$$ |
\$$$$$$$ |\$$$$$$  |\$$$$$$  |\$$$$$$$ |\$$$$$$$ |
 \____$$ | \______/  \______/  \_______| \_______|
$$\   $$ |                                        
\$$$$$$  |                                        
 \______/                                         
`,
		"\n                                             8I             \n                                             8I             \n                                             8I             \n                                             8I             \n   ,gggg,gg    ,ggggg,   gg      gg    ,gggg,8I    ,gggg,gg \n  dP\"  \"Y8I   dP\"  \"Y8gggI8      8I   dP\"  \"Y8I   dP\"  \"Y8I \n i8'    ,8I  i8'    ,8I  I8,    ,8I  i8'    ,8I  i8'    ,8I \n,d8,   ,d8I ,d8,   ,d8' ,d8b,  ,d8b,,d8,   ,d8b,,d8,   ,d8b,\nP\"Y8888P\"888P\"Y8888P\"   8P'\"Y88P\"`Y8P\"Y8888P\"`Y8P\"Y8888P\"`Y8\n       ,d8I'                                                \n     ,dP'8I                                                 \n    ,8\"  8I                                                 \n    I8   8I                                                 \n    `8, ,8I                                                 \n     `Y8P\"                                                  \n",
		`
 ______     ______     __  __     _____     ______    
/\  ___\   /\  __ \   /\ \/\ \   /\  __-.  /\  __ \   
\ \ \__ \  \ \ \/\ \  \ \ \_\ \  \ \ \/\ \ \ \  __ \  
 \ \_____\  \ \_____\  \ \_____\  \ \____-  \ \_\ \_\ 
  \/_____/   \/_____/   \/_____/   \/____/   \/_/\/_/  
`,
		"                                                           \n                                        ,---,              \n              ,---.           ,--,    ,---.'|              \n  ,----._,.  '   ,'\\        ,'_ /|    |   | :              \n /   /  ' / /   /   |  .--. |  | :    |   | |   ,--.--.    \n|   :     |.   ; ,. :,'_ /| :  . |  ,--.__| |  /       \\   \n|   | .\\  .'   | |: :|  ' | |  . . /   ,'   | .--.  .-. |  \n.   ; ';  |'   | .; :|  | ' |  | |.   '  /  |  \\__\\/: . .  \n'   .   . ||   :    |:  | : ;  ; |'   ; |:  |  ,\" .--.; |  \n `---`-'| | \\   \\  / '  :  `--'   \\   | '/  ' /  /  ,.  |  \n .'__/\\_: |  `----'  :  ,      .-./   :    :|;  :   .'   \\ \n |   :    :           `--`----'    \\   \\  /  |  ,     .-./ \n  \\   \\  /                          `----'    `--`---'     \n   `--`-'                                                  \n",
	}

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

	equalDivider := nord9 + strings.Repeat("=", width) + colorReset
	dashDivider := nord10 + strings.Repeat("-", width) + colorReset

	fmt.Println(equalDivider)
	fmt.Printf("%s%s %s %s\n", nord15, strings.Repeat(" ", (width-24)/2), (headers[rand.IntN(len(headers))]), colorReset)
	fmt.Println(equalDivider)

	// Print app info with aligned values
	printField := func(name, value string) {
		fmt.Printf("%s%-15s: %s%s%s\n", nord4, name, nord8, value, colorReset)
	}

	printField("Version", Version)
	printField("Flavour", string(Flavour))
	printField("BinaryPath", filepath.Base(os.Args[0]))
	printField("BuildDate", formatTime(BuildDate))

	fmt.Println(equalDivider)

	printField("Branch", Branch)
	printField("CommitInfo", CommitInfo)
	printField("Source Hash", SourceHash)
	printField("GoVersion", GoVersion)

	if Branch != "unknown" && CommitInfo != "unknown" {
		fmt.Println(dashDivider)
		var baseRepo = fmt.Sprintf("https://github.com/RA341/gouda")
		branchURL := fmt.Sprintf("%s/tree/%s", baseRepo, Branch)
		commitURL := fmt.Sprintf("%s/commit/%s", baseRepo, CommitInfo)

		printField("Repo", baseRepo)
		printField("Branch", branchURL)
		printField("Commit", commitURL)
	}

	fmt.Println(equalDivider)
}
