// use serde_derive::{Deserialize, Serialize};

/// Directories
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Directories {
    /// doc
    ///
    #[serde(default)]
    pub doc: String,
}
/// Scripts
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Scripts {
    /// test
    ///
    #[serde(default)]
    pub test: String,
}
/// Repository
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Repository {
    /// r#type
    ///
    #[serde(default)]
    pub r#type: String,
    /// url
    ///
    #[serde(default)]
    pub url: String,
}
/// Author
/// @see https://serde.rs/enum-representations.html#adjacently-tagged
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, PartialEq, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Author {
    Name(String),
    Full {
        /// name
        ///
        #[serde(default)]
        name: String,
        /// email
        ///
        #[serde(default)]
        email: String,
        /// url
        ///
        #[serde(default)]
        url: String,
    }
}
/// Bugs
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Bugs {
    /// url
    ///
    #[serde(default)]
    pub url: String,
}
/// NpmConfigDefine
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct NpmConfigDefine {
    /// name
    ///
    #[serde(default)]
    pub name: String,
    /// version
    ///
    #[serde(default)]
    pub version: String,
    /// display_name
    ///
    #[serde(
    rename(serialize = "displayName", deserialize = "displayName"),
    default
    )]
    pub display_name: String,
    /// description
    ///
    #[serde(default)]
    pub description: String,
    /// directories
    ///
    #[serde(default)]
    pub directories: Directories,
    /// scripts
    ///
    #[serde(default)]
    pub scripts: Scripts,
    /// repository
    ///
    #[serde(default)]
    pub repository: Repository,
    /// keywords
    ///
    #[serde(default)]
    pub keywords: Vec<String>,
    /// author
    ///
    pub author: Author,
    /// license
    ///
    #[serde(default)]
    pub license: String,
    /// bugs
    ///
    #[serde(default)]
    pub bugs: Bugs,
    /// homepage
    ///
    #[serde(default)]
    pub homepage: String,
}
