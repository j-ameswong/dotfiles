#!/bin/bash

# Create mapping table from <cliphist list>
mapping=$(cliphist list | awk '{print NR-1 "\t" $1 "\t" substr($0, index($0,$2))}')

# Display table in fuzzel and capture selected dmenu index
selected_index=$(echo "$mapping" | cut -f1,3 | fuzzel --dmenu --config=$HOME/.config/fuzzel/fuzzel-clip.ini | awk '{print $1}')

# Use selected index to return id + clipboard content
selected_entry=$(echo "$mapping" | awk -v idx="$selected_index" '$1 == idx {print $2 "\t" substr($0, index($0,$3))}')

# Step 4: Pass the selected entry to `cliphist decode` and copy it to the clipboard
echo -e "$selected_entry" | cliphist decode | wl-copy
