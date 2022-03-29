//
//  ImagePicker.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/29/22.
//
import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}


func saveImage(_ image: UIImage, id: UUID) -> String {
    do {
        // get the documents directory url
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        // choose a name for your image
        let fileName = "\(id).jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = image.jpegData(compressionQuality:  1) {
            // writes the image data to disk
            try data.write(to: fileURL)
            print("file saved")
        }
        
        return "\(fileName)"
    } catch {
        print("error saving image to contact")
    }
    
    return ""
}

func loadImage(for id: UUID) -> Image? {
    do {
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileName = "\(id).jpg"
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        let imageData = try Data(contentsOf: fileURL)
        
        if let uiImg = UIImage(data: imageData) {
            return Image(uiImage: uiImg)
        }
        
        return nil
        
    } catch {
        print("Wasn't able to locate/load the image")
    }
    
    return nil
}
