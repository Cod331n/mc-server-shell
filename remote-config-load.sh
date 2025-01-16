CONFIGS_PATH="./configs" # You may enter here your path
CONFIG_FILE_EXTENSIONS=("*.json" "*.yml" "*.xml") # Specify your file extensions
GITHUB_NAME="Cod331n" # Enter your github name
GITHUB_ACCESS_TOKEN="" # Enter your private access token to repo
REPO_PATH="somethin-configs.git" # Specify your repo path

if [ ! -d "$CONFIGS_PATH" ]; then
    mkdir "$CONFIGS_PATH"
fi

echo "starting getting configs from remote private repository"

cd "$CONFIGS_PATH"

for EXT in "${CONFIG_FILE_EXTENSIONS[@]}"; do
    rm -r ./$EXT
done

git clone --no-tags --single-branch --depth=1 https://$GITHUB_NAME:$GITHUB_ACCESS_TOKEN@github.com/$GITHUB_NAME/$REPO_PATH ./

echo "configs have been created (updated)"

rm -rf ./.git
