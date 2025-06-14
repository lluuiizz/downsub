#!/bin/bash

movie_name="$1"
movie_language="$2"
output_dir="$3"

# Format movie name for URL
formated_movie_name=$(echo "$movie_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '+')

# Search for the movie
search_movie_addr="https://www.opensubtitles.org/en/search2/moviename-${formated_movie_name}/sublanguageid-${movie_language}"
movie_addr=$(curl -s "$search_movie_addr" | \
             grep -Po "'\K[^']*idmovie-[^']*(?=')" | \
             head -n 1)

# Get all subtitle options
id_format_movie_name=$(echo "$formated_movie_name" | tr '+' '-')
sub_options=$(curl -s "https://opensubtitles.org${movie_addr}" | \
              grep -Eo "href=\"/en/subtitles/[0-9]+/${id_format_movie_name}[^\"]*\"" | \
              awk '{print NR ") " $0}')

# Display options with proper formatting
echo "Available subtitles:"
echo "$sub_options" | while read -r line; do
    echo "$line"
done

# Get user selection (only if we found options)
if [ -n "$sub_options" ]; then
    read -p "Choose a subtitle (1-$(echo "$sub_options" | wc -l)): " choosed

    # Validate input
    if [[ ! "$choosed" =~ ^[0-9]+$ ]] || [ "$choosed" -lt 1 ] || [ "$choosed" -gt $(echo "$sub_options" | wc -l) ]; then
        echo "Invalid selection!" >&2
        exit 1
    fi

    # Extract the selected subtitle ID
    selected_line=$(echo "$sub_options" | sed -n "${choosed}p")
    subtitle_id=$(echo "$selected_line" | grep -oE '/en/subtitles/[0-9]+' | cut -d/ -f4)

    echo "Selected subtitle ID: $subtitle_id"
else
    echo "No subtitles found for ${movie_name} in language ${movie_language}" >&2
    exit 1
fi

download_link="https://dl.opensubtitles.org/en/download/sub/${subtitle_id}"

curl --output $3/${id_format_movie_name}.zip ${download_link}
