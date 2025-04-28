# 🛠️ Mini-Grep Bash Script

A simplified version of the `grep` command written in pure Bash!

## 📋 Description

This project replicates the basic functionality of the `grep` command, allowing for:
- Case-insensitive string searching.
- Optional line numbering for matched lines.
- Inverted matches (printing lines that don't match).

Built **without** using `grep` internally — using custom string matching.
==============================================
## 🚀 Usage

```bash
./mygrep.sh [OPTIONS] SEARCH_STRING FILENAME
==============================================
## 🧠 How Searching Algorithm Works

- Convert each line and the search string to lowercase using "tr".
- Compare using "Bash pattern matching" ([[ ... == *pattern* ]]).

✅ Example:

Line: "Hello World" → "hello world"
Search: "hello" → "hello"

Match: ✅
==============================================
💬 Why This Algorithm ?

- simple and quick implementation.
- good performance for small to medium text files.
- compatible with all standard linux shells.
- easy to read and understand.
==============================================
🔥 Bonus Features

- (--help/-h) supported with nice usage message.
- cleaner option parsing using (getopts).
- custom "no match found" message.
==============================================
