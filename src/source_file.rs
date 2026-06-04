use std::fs;
use std::fs::File;
use std::path::PathBuf;

use zip::ZipArchive;

pub fn download_file(
    url: url::Url,
    output_dir: &PathBuf,
) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let filename = url
        .path_segments()
        .and_then(|seg| seg.last())
        .expect("Couldn't figure out filename from given url");
    let output_path = output_dir.join(filename);

    match output_path.try_exists()? {
        true => Ok(output_path),
        false => {
            fs::create_dir_all(&output_path.parent().unwrap())?;
            let mut response = reqwest::blocking::get(url)?;
            let mut file = File::create(&output_path)?;
            std::io::copy(&mut response, &mut file)?;
            Ok(output_path)
        }
    }
}

pub fn unzip_file(
    path: PathBuf,
    output_dir: &PathBuf,
) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let archive = File::open(&path)?;
    let mut archive = ZipArchive::new(archive)?;
    let filename = path.file_stem().unwrap();
    archive.extract(&output_dir)?;
    Ok(output_dir.join(filename))
}
