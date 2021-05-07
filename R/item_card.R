item_card <- function(title, description, image_url, publish_date, author) {
  preview_images <- list(
    list(
      previewImageSrc = image_url,
      width = 318,
      height = 196
    )
  )
  
  shiny.fluent::DocumentCard(
    DocumentCardPreview(previewImages = preview_images),
    DocumentCardTitle(
      title = title,
      shoudTruncate = TRUE
    ),
    DocumentCardTitle(
      title = description,
      shoudTruncate = TRUE,
      showAsSecondaryTitle = TRUE
    ),
    DocumentCardActivity(
      activity = glue::glue("Published on {publish_date}"),
      people = list(list(name = author, profileImageSrc = '', initials = "AA"))
    )
  )
}
