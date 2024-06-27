# EngineerFinder

## Overview

EngineerFinder is a macOS CLI application designed to automate the hiring process by parsing a JSON input containing a list of engineers and their teams. It organizes and prints a list of candidates grouped by their companies.

## Usage

### Input JSON Structure

The application expects a JSON file with the following structure:

```json
[
    {
        "team": "Engineering (Back-end)",
        "people": [
            {
                "full_name": "Alex Bowman",
                "email": "alexbowman@apple.com",
                "reports": [
                    {
                        "full_name": "Barry Johnson",
                        "email": "barryjohnson@gmail.com"
                    }
                ]
            }
        ]
    },
    {
        "team": "Engineering (Mobile)",
        "people": [
            {
                "full_name": "Chris Madison",
                "email": "chrismadison@aol.com"
            }
        ],
        "subteams": [
            {
                "team": "iOS",
                "people": [
                    {
                        "full_name": "David Wasserman",
                        "email": "dwasserman@yahoo.com"
                    }
                ]
            }
        ]
    }
]
```

### Output Format

The application prints a list of engineers grouped by their companies in the following format:

```
AOL:
Chris Madison; Engineering (Mobile); chrismadison@aol.com
APPLE:
Alex Bowman; Engineering (Back-end); alexbowman@apple.com
GMAIL:
Barry Johnson; Engineering (Back-end); barryjohnson@gmail.com
YAHOO:
David Wasserman; Engineering (Mobile) - iOS; dwasserman@yahoo.com
```

### Notes
- The list does not contain duplicates.
- All people who work in the same company are listed under the company name.
- Company name based on email domain of engineers.
- Every team might have subteams, and every person might have several reports.
- The application reads the file from standard input.

## How to Run

1. Navigate to the project directory:
    ```sh
    cd <path_to_the_root_of_this_repository>
    ```
2. Build the project:
    ```sh
    xcodebuild -project ./HW_7/EngineerFinder/EngineerFinder.xcodeproj -scheme EngineerFinder -configuration Release -derivedDataPath ./build
    ```
3. Run the application with the JSON file as input:
    ```sh
    cat path/to/your/file.json | ./build/Build/Products/Release/EngineerFinder
    ```
    
## Data Flow Scheme
![Data flow](./DataFlow.png?raw=true)
