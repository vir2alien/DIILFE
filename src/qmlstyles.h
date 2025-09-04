#ifndef QMLSTYLES_H
#define QMLSTYLES_H

#include <QObject>
#include <QColor>
#include <QFont>
#include <QMap>

class QmlStylesBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double baseGap READ getBaseGap WRITE setBaseGap NOTIFY baseGapChanged)
    Q_PROPERTY(int baseMargins READ getMargins WRITE setMargins NOTIFY marginsChanged)
    Q_PROPERTY(int popupMargins READ getPopupMargins WRITE setPopupMargins NOTIFY popupMarginsChanged)
    Q_PROPERTY(int tableRowHeight READ getTableRowHeight WRITE setTableRowHeight NOTIFY tableRowHeightChanged)
    Q_PROPERTY(int buttonIconSize READ getButtonIconSize WRITE setButtonIconSize NOTIFY buttonIconSizeChanged)

public:
    enum TypeScale {
        H1, H2, H3, H4, H5, H6, Subtitle1, Subtitle2, Body1, Body2, BUTTON, Caption, Overline
    };
    Q_ENUMS(TypeScale)
    explicit QmlStylesBase(QObject *parent = nullptr);
    virtual ~QmlStylesBase() {}

    double getBaseGap() const;
    int getMargins() const;
    int getPopupMargins() const;
    int getTableRowHeight() const;
    int getButtonIconSize() const;

    void setBaseGap(double base_gap);
    void setMargins(int margins);
    void setPopupMargins(int margins);
    void setTableRowHeight(int height);
    void setButtonIconSize(int size);

    Q_INVOKABLE QFont getFont(TypeScale type_scale);

signals:
    void baseGapChanged(double baseGap);
    void marginsChanged(int margins);
    void popupMarginsChanged(int margins);
    void tableRowHeightChanged(int height);
    void buttonIconSizeChanged(int size);

protected:
    bool is_mobile_;
    double base_gap_;
    int base_margins_;
    int popup_margins_;
    int table_row_height_;
    int button_icon_size_;

    const qreal BASE_DPI = 96.;

    QMap<TypeScale, QFont> fonts_;
    QString font_name_ = "Arial";
};

class QmlStylesMobile : public QmlStylesBase
{
    Q_OBJECT
public:
    explicit QmlStylesMobile(QObject *parent = nullptr);
    ~QmlStylesMobile() {}
};

class QmlStylesDesktop : public QmlStylesBase
{
    Q_OBJECT
public:
    explicit QmlStylesDesktop(QObject *parent = nullptr);
    ~QmlStylesDesktop() {}
};

#endif // QMLSTYLES_H
