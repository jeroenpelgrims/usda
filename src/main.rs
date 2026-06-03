use std::path::PathBuf;

use clap::Parser;
use url::Url;

mod source_file;

#[derive(Parser)]
#[command(name = "usda-db")]
struct Cli {
    #[arg()]
    url: Url,

    #[arg(short, long, default_value = "downloads")]
    output_dir: PathBuf,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let path = source_file::download_file(cli.url)?;
    let zip_folder = source_file::unzip_file(path)?;
    // import into db
    Ok(())
}
