from PIL import Image
import numpy as np
from collections import Counter

def get_dominant_color(image_path, num_colors=5):
    """Extract dominant colors from an image"""
    image = Image.open(image_path)
    # Resize image to speed up processing
    image = image.resize((150, 150))
    # Convert to RGB
    image = image.convert('RGB')
    # Get all colors
    all_colors = []
    for x in range(image.width):
        for y in range(image.height):
            r, g, b = image.getpixel((x, y))
            all_colors.append((r, g, b))

    # Count color frequencies
    color_counts = Counter(all_colors)
    # Get most common colors
    most_common = color_counts.most_common(num_colors)

    return most_common

# Extract colors from the primary icon
colors = get_dominant_color('Primary Icon.png')

print("Dominant colors from Primary Icon.png:")
for i, (color, count) in enumerate(colors):
    r, g, b = color
    hex_color = f"#{r:02x}{g:02x}{b:02x}"
    print(f"Color {i+1}: RGB{color} -> Hex: {hex_color}")

    # Generate Material Color swatch
    print(f"  MaterialColor: Color(0xFF{r:02x}{g:02x}{b:02x}),")

    # Calculate luminance to determine if light or dark
    luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    brightness = "light" if luminance > 0.5 else "dark"
    print(f"  Brightness: {brightness}")
    print()