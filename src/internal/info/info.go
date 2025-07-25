package info

import (
	"github.com/RA341/gouda/pkg/litany"
	"os"
	"path/filepath"
)

// build args to modify vars
//
//go build -ldflags "\
// -X github.com/RA341/gouda/internal/info.Version=0.1.0 \
// -X github.com/RA341/gouda/internal/info.CommitInfo=$(git rev-parse HEAD) \
// -X github.com/RA341/gouda/internal/info.BuildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
// -X github.com/RA341/gouda/internal/info.Branch=$(git rev-parse --abbrev-ref HEAD) \
// "
//cmd/server.go

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

	fields := litany.NewFieldConfig()

	fields.NewStrField("Version", Version)
	fields.NewStrField("Flavour", string(Flavour))
	fields.NewStrField("BuildDate", litany.TimeFormatter(BuildDate))
	fields.NewStrField("GoVersion", GoVersion)
	if !IsDocker() {
		// show tracing for server and desktop binaries,
		// we don't need for docker since its immutable
		fields.NewStrField("BinaryPath", filepath.Base(os.Args[0]))
	}

	if IsKnown(Branch) && IsKnown(CommitInfo) {
		fields.DashDivider()
		fields.NewGithubMetadata(
			"https://github.com/RA341/gouda",
			CommitInfo,
			Branch,
		)
	}

	fields.EqualDivider()

	litany.Announce(headers, fields)
}
