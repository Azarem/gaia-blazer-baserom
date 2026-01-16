import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, resolve } from 'path';

/**
 * Recursively finds all .asm files in a directory
 */
function findAsmFiles(dirPath: string): string[] {
    const asmFiles: string[] = [];
    
    try {
        const entries = readdirSync(dirPath);
        
        for (const entry of entries) {
            const fullPath = join(dirPath, entry);
            const stat = statSync(fullPath);
            
            if (stat.isDirectory()) {
                asmFiles.push(...findAsmFiles(fullPath));
            } else if (stat.isFile() && entry.endsWith('.asm')) {
                asmFiles.push(fullPath);
            }
        }
    } catch (error) {
        console.error(`Error reading directory ${dirPath}:`, error);
    }
    
    return asmFiles;
}

/**
 * Extracts string entries from ASM file content
 * Pattern: asciistring_HEXID |CONTENT|
 */
function extractStringsFromFile(filePath: string): Record<string, string> {
    const strings: Record<string, string> = {};
    
    try {
        const content = readFileSync(filePath, 'utf-8');
        const lines = content.split('\n');
        
        // Pattern to match: asciistring_HEXID |CONTENT|
        // Handle optional \r for Windows line endings
        const stringPattern = /^asciistring_([0-9A-Fa-f]+)\s+\|(.*?)\|\r?$/;
        
        for (const line of lines) {
            const match = line.match(stringPattern);
            if (match) {
                const hexId = match[1].toUpperCase();
                const stringContent = match[2];
                strings[hexId] = stringContent;
            }
        }
    } catch (error) {
        console.error(`Error reading file ${filePath}:`, error);
    }
    
    return strings;
}

/**
 * Extracts all string entries from ASM files in the specified path
 * and saves them to strings.json
 */
export function extractStrings(inPath: string): void {
    const resolvedPath = resolve(inPath);
    console.log(`Scanning for .asm files in: ${resolvedPath}`);
    
    // Find all .asm files
    const asmFiles = findAsmFiles(resolvedPath);
    console.log(`Found ${asmFiles.length} .asm files`);
    
    // Extract strings from all files
    const allStrings: Record<string, string> = {};
    let totalStrings = 0;
    
    for (const asmFile of asmFiles) {
        const fileStrings = extractStringsFromFile(asmFile);
        const count = Object.keys(fileStrings).length;
        
        if (count > 0) {
            console.log(`  ${asmFile}: ${count} strings`);
            Object.assign(allStrings, fileStrings);
            totalStrings += count;
        }
    }
    
    console.log(`\nTotal strings extracted: ${totalStrings}`);
    
    // Write to strings.json
    const outputPath = join(resolvedPath, 'strings.json');
    writeFileSync(outputPath, JSON.stringify(allStrings, null, 2), 'utf-8');
    console.log(`\nStrings saved to: ${outputPath}`);
}

// CLI handler - only execute when run directly
const isMainModule = process.argv[1]?.includes('extractStrings.ts') || process.argv[1]?.includes('extractStrings.js');

if (isMainModule) {
    const inPath = process.argv[2] || './extracted/system';
        
    try {
        extractStrings(inPath);
    } catch (error) {
        console.error('Error:', error);
        process.exit(1);
    }
}
