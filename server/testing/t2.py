import cv2
import numpy as np


def detect_cracks(image_path):
    # Load the image
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

    # Apply image preprocessing (e.g., thresholding, blurring) to enhance crack visibility
    blurred = cv2.GaussianBlur(image, (5, 5), 0)
    _, thresholded = cv2.threshold(
        blurred, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

    # Perform morphological operations to fill gaps and reduce noise
    kernel = np.ones((3, 3), np.uint8)
    dilated = cv2.dilate(thresholded, kernel, iterations=2)
    closing = cv2.morphologyEx(dilated, cv2.MORPH_CLOSE, kernel)

    # Find contours in the image
    contours, _ = cv2.findContours(
        closing, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Iterate through the contours and filter out smaller ones (adjust the area threshold as needed)
    min_area_threshold = 100
    detected_cracks = []
    for contour in contours:
        area = cv2.contourArea(contour)
        if area > min_area_threshold:
            # Calculate the bounding rectangle for the contour
            x, y, w, h = cv2.boundingRect(contour)
            detected_cracks.append((x, y, x + w, y + h))

    return detected_cracks


# Example usage
image_path = 'car.jpeg'
image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

cracks = detect_cracks(image_path)
for crack in cracks:
    x1, y1, x2, y2 = crack
    cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)

# Display the image with detected cracks
cv2.imshow('Detected Cracks', image)
cv2.waitKey(0)
cv2.destroyAllWindows()





###################################   DENT  #####################################
# import cv2
# import numpy as np


# def detect_dents(image_path):
#     # Load the image
#     image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

#     # Apply image preprocessing (e.g., thresholding, blurring) to enhance dent visibility
#     blurred = cv2.GaussianBlur(image, (5, 5), 0)
#     _, thresholded = cv2.threshold(
#         blurred, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

#     # Perform morphological operations to fill gaps and reduce noise
#     kernel = np.ones((3, 3), np.uint8)
#     dilated = cv2.dilate(thresholded, kernel, iterations=2)
#     closing = cv2.morphologyEx(dilated, cv2.MORPH_CLOSE, kernel)

#     # Find contours in the image
#     contours, _ = cv2.findContours(
#         closing, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

#     # Iterate through the contours and filter out smaller ones (adjust the area threshold as needed)
#     min_area_threshold = 100
#     detected_dents = []
#     for contour in contours:
#         area = cv2.contourArea(contour)
#         if area > min_area_threshold:
#             # Calculate the bounding rectangle for the contour
#             x, y, w, h = cv2.boundingRect(contour)
#             detected_dents.append((x, y, x + w, y + h))

#     return detected_dents


# # Example usage
# image_path = 'car_dent.jpg'
# image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
# dents = detect_dents(image_path)
# for dent in dents:
#     x1, y1, x2, y2 = dent
#     cv2.rectangle(image, (x1, y1), (x2, y2), (0, 0, 255), 2)

# # Display the image with detected dents
# cv2.imshow('Detected Dents', image)
# cv2.waitKey(0)
# cv2.destroyAllWindows()
