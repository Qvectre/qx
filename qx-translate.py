#!/usr/bin/env python3
"""
QX Digital Instructions Translation Demo
Demonstrates how DIG elements translate user intent to executable instructions
"""

import yaml
import json
import sys

def parse_qx_dot(file_path):
    """Parse a QX DOT file and extract DIG instructions"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Simple extraction of DIG instructions (in a real implementation, 
        # this would be a proper YAML/QX parser)
        lines = content.split('\n')
        in_dig_section = False
        dig_content = []
        
        for line in lines:
            if '⚙️ DIG' in line or 'DIG:' in line:
                in_dig_section = True
                dig_content.append(line)
            elif in_dig_section:
                if line.strip() and not line.startswith(' ') and not line.startswith('\t'):
                    if not ('id:' in line or 'uc1:' in line or 'txt:' in line or 'metrics:' in line or 'dates:' in line):
                        break
                dig_content.append(line)
        
        return '\n'.join(dig_content)
    
    except Exception as e:
        return f"Error parsing file: {e}"

def translate_to_cli(dig_content):
    """Extract CLI commands from DIG content"""
    lines = dig_content.split('\n')
    commands = []
    
    in_commands = False
    for line in lines:
        line = line.strip()
        if 'commands:' in line:
            in_commands = True
            continue
        elif in_commands and line.startswith('- "'):
            # Extract command from YAML list format
            cmd = line[3:-1]  # Remove '- "' and '"'
            commands.append(cmd)
        elif in_commands and line and not line.startswith('-') and not line.startswith(' '):
            break
    
    return commands

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 qx-translate.py <dot-file>")
        print("Example: python3 qx-translate.py example-digital-instructions.yaml")
        sys.exit(1)
    
    file_path = sys.argv[1]
    
    print("🚀 QX Digital Instructions Translation Demo")
    print("=" * 50)
    print(f"📂 Processing: {file_path}")
    print()
    
    # Parse DIG content
    dig_content = parse_qx_dot(file_path)
    
    if "Error" in dig_content:
        print(f"❌ {dig_content}")
        sys.exit(1)
    
    print("🔍 Extracted DIG Content:")
    print("-" * 30)
    print(dig_content)
    print()
    
    # Translate to CLI commands
    commands = translate_to_cli(dig_content)
    
    if commands:
        print("⚙️ Translated Digital Instructions (CLI):")
        print("-" * 40)
        for i, cmd in enumerate(commands, 1):
            print(f"{i}. {cmd}")
        print()
        
        print("📋 Ready to execute? Copy and paste these commands:")
        print("-" * 50)
        for cmd in commands:
            print(f"$ {cmd}")
    else:
        print("⚠️ No CLI commands found in DIG content")
    
    print("\n✅ Translation complete!")

if __name__ == "__main__":
    main()