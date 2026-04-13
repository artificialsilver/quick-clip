#!/bin/bash

# 1. Install dependencies
sudo apt update && sudo apt install -y xclip wl-clipboard

# 2. Create the enhanced global executable
sudo bash -c "cat << 'EOF' > /usr/local/bin/clip
#!/bin/bash
STORAGE_FILE=\"\$HOME/.clip_storage\"
touch \"\$STORAGE_FILE\"

copy_cmd() {
    if [ \"\$XDG_SESSION_TYPE\" = \"wayland\" ] || [ -n \"\$WAYLAND_DISPLAY\" ]; then
        echo -n \"\$1\" | wl-copy
    else
        echo -n \"\$1\" | xclip -selection clipboard
    fi
}

case \"\$1\" in
    # List all saved snippets
    \"-l\" | \"--list\")
        echo \"--- Saved Clips ---\"
        cat \"\$STORAGE_FILE\" | column -t -s ' '
        ;;
    # Delete a specific snippet
    \"-d\" | \"--delete\")
        if [ -z \"\$2\" ]; then
            echo \"❌ Usage: clip -d [alias]\"
        else
            sed -i \"/^\$2 /d\" \"\$STORAGE_FILE\"
            echo \"🗑️ Deleted: \$2\"
        fi
        ;;
    # Clear all snippets
    \"--clear-all\")
        > \"\$STORAGE_FILE\"
        echo \"🧹 All clips cleared!\"
        ;;
    # Save or Copy
    *)
        if [ \"\$#\" -eq 2 ]; then
            sed -i \"/^\$1 /d\" \"\$STORAGE_FILE\" 2>/dev/null
            echo \"\$1 \$2\" >> \"\$STORAGE_FILE\"
            echo \"✅ Saved successfully to '\$1'.\"
        elif [ \"\$#\" -eq 1 ]; then
            RESULT=\$(grep \"^\$1 \" \"\$STORAGE_FILE\" | cut -d' ' -f2-)
            if [ -z \"\$RESULT\" ]; then
                echo \"❌ Error: No content found for '\$1'.\"
            else
                copy_cmd \"\$RESULT\"
                echo \"📋 Copied to clipboard: \$RESULT\"
            fi
        else
            echo \"📖 Usage:\"
            echo \"  clip [alias] [content]  : Save\"
            echo \"  clip [alias]            : Copy to clipboard\"
            echo \"  clip -l                 : List all\"
            echo \"  clip -d [alias]         : Delete one\"
        fi
        ;;
esac
EOF"

sudo chmod +x /usr/local/bin/clip
echo "✨ Enhanced clip tool installed! Try 'clip -l' to see your list."
