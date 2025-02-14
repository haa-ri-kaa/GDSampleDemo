//
//  ContentView.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            if let tags = post.tags {
                                Text("Tags: \(tags.joined(separator: ", "))")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("English Posts")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    ContentView()
}
