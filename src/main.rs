use clap::Parser;
use std::path::PathBuf;
use url::Url;
mod source_file;

#[derive(Parser)]
#[command(name = "usda-db")]
struct Cli {
    #[arg()]
    url: Url,

    #[arg(short, long, default_value = "downloads")]
    download_dir: PathBuf,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let path = source_file::download_file(cli.url, cli.download_dir.as_path())?;
    let zip_folder = source_file::unzip_file(path.as_path(), cli.download_dir.as_path())?;
    let csv_files = glob::glob(&format!("{}/**/*.csv", zip_folder.display()))?
        .filter_map(Result::ok)
        .collect::<Vec<_>>();

    println!("{:?}", csv_files);
    // csv
    // import_files()
    // import into db
    Ok(())
}
