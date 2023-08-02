//  SettingsRowView.swift
//  Anime Now!
//
//  Created by ErrorErrorError on 12/22/22.
//
//

import SwiftUI
import Utilities

// MARK: - SettingsRowView

public struct SettingsRowView<Accessory: View>: View {
    let name: String
    var tapped: (() -> Void)?
    let accessory: (() -> Accessory)?

    private var loading = false
    private var multiSelection = false
    private var cornerRadius = 0.0
    private let height = 58.0
    private var foregroundColor: Color?

    public var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 13, weight: .bold))

            Spacer(minLength: height / 4)

            if loading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let accessory {
                accessory()
                    .foregroundColor(multiSelection ? nil : .gray)
            }

            if !loading, multiSelection {
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, height / 4)
        .frame(minHeight: height)
        .font(.callout)
        .foregroundColor(loading ? .gray : foregroundColor)
        .background(Color(white: 0.2))
        .cornerRadius(cornerRadius)
        .contentShape(Rectangle())
        .onTapGesture {
            !loading ? tapped?() : ()
        }
    }
}

// MARK: - SettingsSwitch

public struct SettingsSwitch: View {
    @Binding
    var on: Bool

    public var body: some View {
        Toggle(isOn: $on) {
            EmptyView()
        }
        .toggleStyle(.switch)
        .foregroundColor(.primaryAccent)
    }
}

public extension SettingsRowView {
    init(
        name: String,
        tapped: (() -> Void)? = nil
    ) where Accessory == EmptyView {
        self.init(
            name: name,
            tapped: tapped,
            accessory: nil
        )
    }

    init(
        name: String,
        tapped: @escaping () -> Void
    ) where Accessory == Image {
        self.init(
            name: name,
            tapped: tapped
        ) {
            Image(systemName: "chevron.forward")
        }
    }

    init(
        name: String,
        text: String,
        tapped: (() -> Void)? = nil
    ) where Accessory == Text {
        self.init(
            name: name,
            tapped: tapped
        ) {
            Text(text)
                .font(.footnote.bold())
        }
    }

    init(
        name: String,
        active: Binding<Bool>
    ) where Accessory == SettingsSwitch {
        self.init(name: name) {
            withAnimation {
                active.wrappedValue.toggle()
            }
        } accessory: {
            SettingsSwitch(on: active)
        }
    }

    init(
        name: String,
        tapped: (() -> Void)? = nil,
        @ViewBuilder builder: @escaping () -> Accessory
    ) {
        self.init(
            name: name,
            tapped: tapped,
            accessory: builder
        )
    }

    static func views(
        name: String,
        @ViewBuilder views: @escaping () -> some View
    ) -> some View where Accessory == EmptyView {
        VStack(spacing: 0) {
            SettingsRowView(name: name, accessory: nil)
            views()
        }
        .background(Color(white: 0.2).frame(maxWidth: .infinity, maxHeight: .infinity))
    }
}

extension SettingsRowView {
    private struct ExpandableListView<T: Equatable & Identifiable, I: View>: ViewModifier {
        let items: [T]
        let onSelected: (T.ID) -> Void
        let itemView: (T) -> I

        @State
        private var expand = false

        func body(content: Content) -> some View {
            LazyVStack(spacing: 0) {
                content
                    .highPriorityGesture(
                        TapGesture()
                            .onEnded {
                                withAnimation {
                                    expand.toggle()
                                }
                            }
                    )

                Spacer(minLength: 0)
                    .fixedSize()

                if expand {
                    ForEach(items, id: \.id) { item in
                        LazyVStack {
                            Color.gray.opacity(0.25)
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .padding(.horizontal)

                            itemView(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        expand = false
                                    }
                                    onSelected(item.id)
                                }
                        }
                        .background(Color(white: 0.2))
                    }
                }
            }
        }
    }

    public static func listSelection<T: Equatable & Identifiable & CustomStringConvertible>(
        name: String,
        selectable: Selectable<T>,
        loading: Bool = false,
        onSelectedItem: @escaping (T.ID) -> Void,
        @ViewBuilder itemView: @escaping (T) -> some View
    ) -> some View where Accessory == Text {
        let view = SettingsRowView(
            name: name,
            text: selectable.item?.description ?? ((selectable.items.isEmpty) ? "Unavailable" : "Not Selected")
        )
        .multiSelection(selectable.items.count > 1)
        .loading(loading)

        return view
            .modifier(
                ExpandableListView(
                    items: selectable.items,
                    onSelected: onSelectedItem,
                    itemView: itemView
                )
            )
    }
}

public extension SettingsRowView {
    func onTapped(_ callback: @escaping () -> Void) -> Self {
        var view = self
        view.tapped = callback
        return view
    }

    func multiSelection(_ multiSelection: Bool) -> Self {
        var view = self
        view.multiSelection = multiSelection
        return view
    }

    func loading(_ isLoading: Bool) -> Self {
        var view = self
        view.loading = isLoading
        return view
    }

    func cornerRadius(_ cornerRadius: CGFloat = 12.0) -> Self {
        var view = self
        view.cornerRadius = cornerRadius
        return view
    }

    func foregroundColor(_ color: Color?) -> Self {
        var view = self
        view.foregroundColor = color
        return view
    }
}

// MARK: - SettingsRowViewV2Previes

struct SettingsRowViewV2Previes: PreviewProvider {
    static var previews: some View {
        SettingsRowView(name: "Yes", active: .constant(true))
    }
}
