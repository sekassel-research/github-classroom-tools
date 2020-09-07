# github-api-bulk-transfer

A utility for transferring multiple GitHub Classroom repositories to a new owner (user or organization).

**THIS UTILITY IS PROVIDED WITH NO WARRANTY OF ANY SORT.
USE OF THIS SOFTWARE IS DEPENDENT ON AN UNSTABLE PREVIEW API AND ITS USE COULD RESULT IN LOSS OF DATA AMONG OTHER CONSEQUENCES.
USE OF THIS SOFTWARE IS EXCLUSIVELY AT YOUR OWN RISK**

## Installation

0. Clone this repository and open up a terminal in the root directory.
1. Install `bash`, `curl`, & `jq` and any dependencies if you don't already have them installed.
2. Create a GitHub Personal Access Token (Settings > Developer Settings > Personal Access Tokens).
3. Create an environment variable called `GITHUB_SECRET` with the token you just created.
4. Create a file named `repos.txt` next to the `bulk_transfer_repos.sh` script.
5. Create a file named `students.txt` next to the `bulk_transfer_repos.sh` script.

## Usage

1. Copy the list of all of your assignments prefixes and paste them into `repos.txt`.
   Put each prefix on a new line and make sure to include the repo owner.
   Example:

   ```
   org/assignment-1
   org/assignment-2
   ...
   ```

2. Copy the list of GitHub usernames of your students into `students.txt`.
   Example:

   ```
   alice
   bob
   charlie
   ...
   ```

3. Execute the program with your username (`Username`) and the name of the new owner (`NewOwner`):
   `bash bulk_transfer_repos.sh Username NewOwner`

## License

All work in this repository is made available under the terms of the AGPLv3 License, a copy of which is provided in the file called `License`. Copyright J.D. Bean 2019
