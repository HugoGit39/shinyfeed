item_card <- function(title, description, image_url, publish_date, author, author_image, on_click_href) {
  preview_images <- list(
    list(
      previewImageSrc = image_url,
      width = 318,
      height = 196
    )
  )
  
  redirect_fun <- glue::glue(
    "function() { window.open('{{ on_click_href }}', '_blank') }",
    .open = "{{",
    .close = "}}"
  )
  
  shiny.fluent::DocumentCard(
    onClick = shiny.react::JS(
      redirect_fun
    ),
    DocumentCardPreview(
      previewImages = preview_images,
      
    ),
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
      people = list(list(name = author, profileImageSrc = ""))
    )
  )
}
