#!/bin/bash

# Função para exibir a mensagem de ajuda
show_help() {
    echo "Uso: $0 <nome_do_filme> <idioma> <diretorio_de_saida>"
    echo ""
    echo "Baixa legendas do OpenSubtitles de forma interativa."
    echo ""
    echo "Argumentos:"
    echo "  <nome_do_filme>       Nome do filme (coloque entre aspas se houver espaços)."
    echo "  <idioma>              Código do idioma (ex: 'pob' para PT-BR, 'eng' para Inglês)."
    echo "  <diretorio_de_saida>  Pasta onde o arquivo .zip da legenda será salvo."
    echo ""
    echo "Opções:"
    echo "  help, -h, --help      Mostra esta mensagem de ajuda e sai."
    echo ""
    echo "Exemplo:"
    echo "  $0 \"The Matrix\" pob /home/usuario/Downloads"
}

# Verifica se o usuário pediu ajuda
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Verifica se o número exato de argumentos (3) foi passado
if [ "$#" -ne 3 ]; then
    echo "Erro: Faltam argumentos necessários." >&2
    show_help
    exit 1
fi

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
